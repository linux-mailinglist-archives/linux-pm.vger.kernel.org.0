Return-Path: <linux-pm+bounces-28121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E840DACE1F8
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 18:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2979175638
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 16:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DE71CB518;
	Wed,  4 Jun 2025 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="O7CYB3Ks"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08AC4C7C;
	Wed,  4 Jun 2025 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053492; cv=none; b=EVVQPfoB3yusHixU121VvRIbUDFjQUODz+3jIxukgfqnE9gZPop+NBYXWyM8JKFLT2yAEgGCycObjsoGbQAHiPNeldQzmxT/NPnafjkk6jgoT4+9DTYRBqXcaY0Y8gJphrwX/XGK5RFIxiUVLpdt4EvbJ5c/HxAiXhIstShr19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053492; c=relaxed/simple;
	bh=o/cPNVE3IdWBRcC848YHNgxMGl8ijLAQ/13S2yCccfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRE/XSS/QSiMNgBNPhW4hJVAQ39N48Z7ogTczcx/kczdo0pTzwGsiAvxOpy8qe+jBtj3GEaPdRSIVWSo4Ll8Rt93+D7REter2pF2X70PX2Ezeqez3Exz42hzAVISzjBUHuzcqTBcRSg1mvJ4Ms80YNcx+4jdtIGdrbw0yEKu82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=O7CYB3Ks; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B02BrHbdgIss0dPNetAPZKJEyGmeDOjXRF/xIMFxZOM=; b=O7CYB3KsKEIXdt1ubyBxCuiVfh
	BOTw+/wS846kP1BPAr07Jn3Lv1szyyNAF6+tX4RF12MD4aMWWm4ZwxlGz2E11lhhg23/Q/CKUTZq6
	rx5bXu79EbBM9a5Ukygx88oeWGITC+P9ETlQO8bX+uab28CnaER5iS2oBgH+RPbL2Y62Hvj7O8v0y
	p5QxIapGA+OBhx6G3GOP5/LzAcVHF2rWgQ/ZIRQE0vUpTu1ajgehsGvOMp5EBf6FwY5Jswf/n3we9
	yytXgwVsc4pBIPMtrNNjgoXWiuffh3hdnRR6+DJFMRFoAGYLe/a1IDrnrktpH73erV99I7Y/0vOir
	0GrN1pEQ==;
Received: from [37.209.163.134] (helo=[172.16.18.203])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uMqhk-00HASL-04; Wed, 04 Jun 2025 18:11:04 +0200
Message-ID: <be23f55c-329c-444d-b5d8-83ae29b05387@igalia.com>
Date: Wed, 4 Jun 2025 18:11:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] PM: EM: Add the infrastructure for command
 processing.
To: Lukas Wunner <lukas@wunner.de>
Cc: lukasz.luba@arm.com, rafael@kernel.org, len.brown@intel.com,
 pavel@kernel.org, christian.loehle@arm.com, tj@kernel.org,
 kernel-dev@igalia.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250529001315.233492-1-changwoo@igalia.com>
 <20250529001315.233492-5-changwoo@igalia.com> <aD4CrOmIwhUI-pet@wunner.de>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <aD4CrOmIwhUI-pet@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/2/25 04:59, Lukas Wunner wrote:
> On Thu, May 29, 2025 at 09:13:08AM +0900, Changwoo Min wrote:
>> +static int em_genl_cmd_doit(struct sk_buff *skb, struct genl_info *info)
>> +{
>> +	struct param p = { .attrs = info->attrs };
>> +	struct sk_buff *msg;
>> +	void *hdr;
>> +	int cmd = info->genlhdr->cmd;
>> +	int ret = -EMSGSIZE;
>> +
>> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>> +	if (!msg)
>> +		return -ENOMEM;
> 
> Just a heads-up, I know everyone recommends NLMSG_GOODSIZE but in reality
> it's not that great because netlink_trim() reallocates the skb and copies
> the entire linear buffer if it determines that the skb is half-empty.
> Performance suffers as a result.  So it's actually better to calculate
> the exact message length prior to allocation.
Thank you, Lukas, for sharing the experience. I will address it in the
next version.

Regards,
Changwoo Min

