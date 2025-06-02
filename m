Return-Path: <linux-pm+bounces-27977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B813ACBC14
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 22:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C897171DD6
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 20:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD7E1FBCAA;
	Mon,  2 Jun 2025 19:59:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A163A1AA786;
	Mon,  2 Jun 2025 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748894391; cv=none; b=VV5Ox0tTxAzaeQT26VomA16fZdL524XMYO9LF5L5JkkniSoWtOwwBG71yoECa6IMKhPH06kQj1O4yVbVZiApcocRijFTnOzBgNx5kBXZdd8a8JhZc+PsQwYnN4EagwBnWk9h+XumtImUfinJ8y1Sgn5aiRYQcUaIG6OnZRd3SJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748894391; c=relaxed/simple;
	bh=wuD9ZkdesExAhQhkMLxllx71KQ+NvGKgJo+ngi9MnzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diZ83hsoaULed14ydOzskW8ot/CTMs9lFaGr5K7yAVcVWJsLubCJcr6mXCZcH3VQxlc/vsv5i2fTO/p26TfNsBxGJEni3lqT43wMjgfcNTbR8vFICgB3vU4EbARs+PDXUNzO/xn48twdJsX+eyeStvebe2r14L5NX+IIM8N+QUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id C8707200A28D;
	Mon,  2 Jun 2025 21:59:40 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B3C922F90D4; Mon,  2 Jun 2025 21:59:40 +0200 (CEST)
Date: Mon, 2 Jun 2025 21:59:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, len.brown@intel.com,
	pavel@kernel.org, christian.loehle@arm.com, tj@kernel.org,
	kernel-dev@igalia.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] PM: EM: Add the infrastructure for command
 processing.
Message-ID: <aD4CrOmIwhUI-pet@wunner.de>
References: <20250529001315.233492-1-changwoo@igalia.com>
 <20250529001315.233492-5-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529001315.233492-5-changwoo@igalia.com>

On Thu, May 29, 2025 at 09:13:08AM +0900, Changwoo Min wrote:
> +static int em_genl_cmd_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct param p = { .attrs = info->attrs };
> +	struct sk_buff *msg;
> +	void *hdr;
> +	int cmd = info->genlhdr->cmd;
> +	int ret = -EMSGSIZE;
> +
> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;

Just a heads-up, I know everyone recommends NLMSG_GOODSIZE but in reality
it's not that great because netlink_trim() reallocates the skb and copies
the entire linear buffer if it determines that the skb is half-empty.
Performance suffers as a result.  So it's actually better to calculate
the exact message length prior to allocation.  See the SPDM commit
referenced in my previous e-mail.  Another lesson I had to learn the
hard way. :(

Thanks,

Lukas

