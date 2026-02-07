Return-Path: <linux-pm+bounces-42251-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJjeKo9uh2nQXwQAu9opvQ
	(envelope-from <linux-pm+bounces-42251-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 17:55:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D4C10692F
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 17:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 743FB301FA5E
	for <lists+linux-pm@lfdr.de>; Sat,  7 Feb 2026 16:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E4533858B;
	Sat,  7 Feb 2026 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xm/EAPH0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AAD2032D;
	Sat,  7 Feb 2026 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770483337; cv=none; b=uFZTxQ/DdVyM4WlNWFxVH3364XUfupvUJrjfNW9o7FTxILPI9ciBG3iowQw3E2ck49MrLEj8cuxmjaOaNbmBOVxFDFs94te231oTc6HVGt6xQU50+WzdGAzeZ1tjD/awplzD8mLI+JuPqDi0n44gAgVI9N78r3iXY5VKMgwiM3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770483337; c=relaxed/simple;
	bh=XF9COcQaEIHxmp/l00Iy1/CqeeTFCLR4L/6pxLAwvvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oC3AmEj9WDpJUN62xZkxmhqnF1ApiVRD6NN3YGO6HnvyZYiTbsAHSbnbPYooOCmmM2sdhwS8pOhkqucYSYStOwocTbMiMltgEl2NYgIzJvk4lz4JG/sXBGIkq39HUF2Jnzr9tvrUNZsr+UKUTZVmBSrUG4jzF1IBrWA/6tgrZpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xm/EAPH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC5DC116D0;
	Sat,  7 Feb 2026 16:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770483337;
	bh=XF9COcQaEIHxmp/l00Iy1/CqeeTFCLR4L/6pxLAwvvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xm/EAPH0UFspdYzw4r7tfbOG5sOHicbWcvjbhhnimUgf4hWVzA4BQd6DCFteRRyRW
	 h3Dkf06CwEtLgfm7z+mZbkYTxWX3EGeNjU4rtak2JHGiGI6XtNhmLaEti1KUjDxJga
	 lVkgy2y57prp8QWlNpQhSx9XJc59yQzulT3dm6hJ8Xrxd5kCt4QCbqUT79gdftSwK+
	 jE6rn5oMuTcgrUPW22cKUJtYp5V5P45VA7rA2/lK8GD4yEhRu0wt4qTaRWUEa6SQx2
	 enDcFT8YH6YC8YN36fWwrbxkKTuP5ybYaZ90eg3nhYpcTZPz407Zvos2OLysvgXTg3
	 BBkVsfRzmJRkQ==
Date: Sat, 7 Feb 2026 16:55:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
 dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
 daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
 thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
 subbaraman.narayanamurthy@oss.qualcomm.com, david.collins@oss.qualcomm.com,
 anjelique.melendez@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com,
 rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
 neil.armstrong@linaro.org, stephan.gerhold@linaro.org
Subject: Re: [PATCH V10 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
Message-ID: <20260207165521.357c1fb0@jic23-huawei>
In-Reply-To: <def530e3-3a5d-41cd-9f1a-1dc3f98747f9@oss.qualcomm.com>
References: <20260130115421.2197892-1-jishnu.prakash@oss.qualcomm.com>
	<20260130115421.2197892-5-jishnu.prakash@oss.qualcomm.com>
	<20260131175412.0ded39d4@jic23-huawei>
	<def530e3-3a5d-41cd-9f1a-1dc3f98747f9@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42251-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,linaro.org,gmail.com,intel.com,arm.com,vger.kernel.org,chromium.org,quicinc.com];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 10D4C10692F
X-Rspamd-Action: no action

On Fri, 6 Feb 2026 18:45:22 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Hi Jonathan,
> 
> On 1/31/2026 11:24 PM, Jonathan Cameron wrote:
> > On Fri, 30 Jan 2026 17:24:21 +0530
> > Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> >   
> >> Add support for ADC_TM part of PMIC5 Gen3.
> >>
> >> This is an auxiliary driver under the Gen3 ADC driver, which implements the
> >> threshold setting and interrupt generating functionalities of QCOM ADC_TM
> >> drivers, used to support thermal trip points.
> >>
> >> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>  
> > 
> > Hi Jishnu.
> > 
> > Some minor editorial style stuff below if you are spinning again.
> > Otherwise this looks good to me
> > 
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Given I expect this patch will go through the thermal tree and not IIO.  
> 
> Just to confirm, would it be fine to keep your Reviewed-by tag in place
> if I only make changes in this patch to address your comments, in the
> next patch series?
When you say next patch series do you mean a v11? Or a separate follow up series?
We have time now as the necessary immutable branch won't be for at least 2 weeks
(need rc1 to be released).

Yes.  You only need to drop tags if making significant changes from what
was tagged.  If you do drop them once given, call out why under the --- for the
new patch.

Jonathan


> 


