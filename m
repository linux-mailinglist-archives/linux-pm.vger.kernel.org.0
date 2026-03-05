Return-Path: <linux-pm+bounces-43667-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKoeNK9UqWkj4wAAu9opvQ
	(envelope-from <linux-pm+bounces-43667-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 11:02:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C58420F3D8
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 11:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD85430FC518
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 09:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EBD37646C;
	Thu,  5 Mar 2026 09:57:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22CF37AA6F
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704667; cv=none; b=RlE8mvM5o4Xku6vQL9qWALgc/mZFp4n4CWUx4GwI3jUe50rU86f+gy4sCH/WPJYD3uODZhL7oQPdojQucqlA3i9RkUixvaL9ACvxRSMhClpl+0ECGwuSkTZ/AQBkQuIvoeztOPY+V5M7IrvRb3VJUI2ya1tSHNuhtg/hC3rf1kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704667; c=relaxed/simple;
	bh=uBvyWVTQJgEJMinbZzCcQyA6ExC1ldyFrsgOrBO2ZGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxP5o92ZVsyRnYov+L3nJIAjBs27uPODKdCUJfR1COPa/haXeKFDbmE8WGl+VJLxQm914uUqlQTtZQ7VyFsqyx4fvpVSl8U9NDCDcxD0JW+ATTxlV4ZiDzpYVsyY5UCKuqGLGbXfY/aPYrf3h7GLEFCqA8cdiH3JGjZ1B4FTEFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vy5SO-0005fW-Ni; Thu, 05 Mar 2026 10:57:24 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vy5SM-003rSo-2D;
	Thu, 05 Mar 2026 10:57:24 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1vy5SN-00000002FW3-3jOJ;
	Thu, 05 Mar 2026 10:57:23 +0100
Date: Thu, 5 Mar 2026 10:57:23 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: ming.qian@oss.nxp.com, linux-media@vger.kernel.org, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca, benjamin.gaignard@collabora.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de, 
	sebastian.fricke@collabora.com, shawnguo@kernel.org, ulf.hansson@linaro.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	fra.schnyder@gmail.com, linux-imx@nxp.com, l.stach@pengutronix.de, Frank.li@nxp.com, 
	peng.fan@nxp.com, eagle.zhou@nxp.com, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] media: verisilicon: Fix kernel panic due to __initconst
 misuse
Message-ID: <ayefolxtgwfmvs5h5ln7u4hdope4rdthvpiacdbfbnxe33lgzb@vts2vnib3t7w>
References: <20260305080354.639-1-ming.qian@oss.nxp.com>
 <j4h65w6rwsd227gooa437qfp43z3vtiyaegehbe5md3f22anae@lprbmtart3km>
 <68ef934f-baa0-4bf6-93d8-834bbc441e66@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ef934f-baa0-4bf6-93d8-834bbc441e66@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Rspamd-Queue-Id: 7C58420F3D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-43667-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[oss.nxp.com,vger.kernel.org,kernel.org,xs4all.nl,ndufresne.ca,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,lists.linux.dev,lists.infradead.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.felsch@pengutronix.de,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.956];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:email,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 26-03-05, Krzysztof Kozlowski wrote:
> On 05/03/2026 10:01, Marco Felsch wrote:
> > Hi Ming,
> > 
> > On 26-03-05, ming.qian@oss.nxp.com wrote:
> >> From: Ming Qian <ming.qian@oss.nxp.com>
> >>
> >> Fix a kernel panic when probing the driver as a module:
> >>
> >>   Unable to handle kernel paging request at virtual address
> >>   ffffd9c18eb05000
> >>   of_find_matching_node_and_match+0x5c/0x1a0
> >>   hantro_probe+0x2f4/0x7d0 [hantro_vpu]
> >>
> >> The imx8mq_vpu_shared_resources array is referenced by variant
> >> structures through their shared_devices field. When built as a
> >> module, __initconst causes this data to be freed after module
> >> init, but it's later accessed during probe, causing a page fault.
> >>
> >> Use __initconst_or_module to keep the data available when built
> >> as a module while still allowing it to be freed when built-in.
> > 
> > would be nice if I get at least some credit for pointing to the correct
> > fix ;)
> > 
> >> Fixes: e0203ddf9af7 ("media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC")
> >> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> > 
> > However, patch looks fine:
> > 
> > Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> Patch is not correct. This is being referenced from other data where
> nothing is __init. Section mismatch might not point it, but I don't
> think the code is readable and actually correct.
> 
> You can exercise it by rebinding device when built-in.

That's correct, I didn't consider the manual unbind for the built-in
case in which you will trigger the issue again! Dropping the annotation
is the correct fix, thanks!

Regards,
  Marco


> 
> Best regards,
> Krzysztof
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

