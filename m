Return-Path: <linux-pm+bounces-4405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F211F8677EC
	for <lists+linux-pm@lfdr.de>; Mon, 26 Feb 2024 15:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDC229104A
	for <lists+linux-pm@lfdr.de>; Mon, 26 Feb 2024 14:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4580012A176;
	Mon, 26 Feb 2024 14:12:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7406E5E4;
	Mon, 26 Feb 2024 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956758; cv=none; b=lm7OHKJctAYLYzcIfx2s71ovpKVv8nDGViSu/usCvdYhjAICW2zTiUyifEBcVXND10CBFPAktlPlIOU6E8w5QVXtyn2qXO+QgKYifvE6EiBGgKagSwHT/rRImPh9lBmwMJhbs2zIR5vl++4J6YkdlhRKRwrNZwA1A5rr3Ykv0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956758; c=relaxed/simple;
	bh=K7emjvZ5wbErjFL548q+J8skjuA84L7fahFpqb0GdtI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sIlMt0L/jYWyCpAqE4lU8elFz9dXumTGjrx7k/L+wU7jSuzJ0QJ3pu9xbNDLzui6AikGZhnzEYdiaDKRW6Icdv4KJ7fycC8JxZpWLxArwWZwximDKvaKSeDDFG/7quS7NOYzI0SZ7vZGC8ul3X02R6OyhQXfO3ROkg2IJDvDT9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3524C43399;
	Mon, 26 Feb 2024 14:12:37 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id F38D71060D1D; Mon, 26 Feb 2024 15:12:34 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Andrew Davis <afd@ti.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <35f04935c48ae55dc562071e0a1d6fca65234a58.1708944642.git.geert+renesas@glider.be>
References: <35f04935c48ae55dc562071e0a1d6fca65234a58.1708944642.git.geert+renesas@glider.be>
Subject: Re: [PATCH] power: reset: rmobile-reset: Make sysc_base2 local
Message-Id: <170895675497.2002775.14460931252287623792.b4-ty@collabora.com>
Date: Mon, 26 Feb 2024 15:12:34 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 26 Feb 2024 11:54:52 +0100, Geert Uytterhoeven wrote:
> The static global variable sysc_base2 is no longer used outside the
> probe method and the reset handler, so it can be converted to a local
> variable, and passed to the reset handler via its callback data.
> 
> 

Applied, thanks!

[1/1] power: reset: rmobile-reset: Make sysc_base2 local
      commit: 3da8d71754d3c1aa0b72d74c8a324a4bc7fab473

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


