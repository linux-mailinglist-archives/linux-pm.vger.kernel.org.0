Return-Path: <linux-pm+bounces-43072-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEdNNUK5nGkqKAQAu9opvQ
	(envelope-from <linux-pm+bounces-43072-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 21:32:02 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A9217CEF4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 21:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0685C302F7F0
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 20:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C95377573;
	Mon, 23 Feb 2026 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOe5FCym"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1A41BC46;
	Mon, 23 Feb 2026 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771878719; cv=none; b=ZnMZWCLNvDLte8idJJ1ogC3d12sSjZI16Mc1exxUhqRFvMswoY6PpYOV+wJ6AFnjrk/mdTLfU2Q4lXOt6zMhhdeX/t4AvxbGgtHnTPwkshrsbB4yU0YjOzc/tYAnqFQp8izftjyXZNHlpMEC8nh0LDGNBNNJXaaW01X+gxnATeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771878719; c=relaxed/simple;
	bh=JVFoYP6O1GtQxzGkQymbRgfqEOvg8wZWDd9t5Qjwppk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BS0irhC/+pDY5rF4RloMJd/g332ba2tKoJDr14Ljkvw2za3BAVbYGj5qcEHBSqal+h7Ni56G+kRe+tazLWEXVO9piC8M+nzSIeRtTfPmCOv89vINFxAejz67MmT/ojZIB4VP7NqUyzt1lMDNr4do6xFcAXy841nZCQtOnh579dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOe5FCym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6254AC116C6;
	Mon, 23 Feb 2026 20:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771878718;
	bh=JVFoYP6O1GtQxzGkQymbRgfqEOvg8wZWDd9t5Qjwppk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nOe5FCymJvzvQhrorcqcuC9zWVQ+MxE5R4ZC88A57t9/fGFGDxeFznV2QmIIkEH0K
	 Yb4FPzgc1AyBsVZs2rm3J0yAREi7wPCleMjttHhZsvgpBkuWi95EOBYpxaRLnvVk10
	 sDFG4uiZXnDgQPyZKIUvUV/hUzjNY1lnSlnvh5CkmP0SrwfsHYAHwmbc38Ix5y2Op5
	 09TpgNmdJy9dvRinFE7HGyTg2g34pLSNvr+5p4pPzKitt2gkvrYR2xaInKKh4hQVxz
	 73FY04gRJsziFxShzjFUbycBWvRlifyJD1nhFSR+Qt6Yee+CQWHrojMGMORsWzlbiG
	 PDtVvM6N9MSSg==
Date: Mon, 23 Feb 2026 20:31:45 +0000
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
Subject: Re: [PATCH V10 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Message-ID: <20260223203145.4a4493a7@jic23-huawei>
In-Reply-To: <70b77d54-a6ab-426e-a7e1-3e011adad6d4@oss.qualcomm.com>
References: <20260130115421.2197892-1-jishnu.prakash@oss.qualcomm.com>
	<20260130115421.2197892-4-jishnu.prakash@oss.qualcomm.com>
	<20260131173941.68b8116d@jic23-huawei>
	<6012ad64-3a10-4f05-9f37-f2d0c36df582@oss.qualcomm.com>
	<20260207165638.0ed27302@jic23-huawei>
	<70b77d54-a6ab-426e-a7e1-3e011adad6d4@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43072-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,linaro.org,gmail.com,intel.com,arm.com,vger.kernel.org,chromium.org,quicinc.com];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 21A9217CEF4
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 17:49:18 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Hi Jonathan,
> 
> On 2/7/2026 10:26 PM, Jonathan Cameron wrote:
> > On Fri, 6 Feb 2026 18:45:02 +0530
> > Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> >   
> >> Hi Jonathan,
> >>
> >> On 1/31/2026 11:09 PM, Jonathan Cameron wrote:  
> >>> On Fri, 30 Jan 2026 17:24:20 +0530
> >>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> >>>     
> >>>> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
> >>>> with all SW communication to ADC going through PMK8550 which
> >>>> communicates with other PMICs through PBS.
> >>>>
> >>>> One major difference is that the register interface used here is that
> >>>> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
> >>>> There may be more than one SDAM used for ADC5 Gen3 and each has eight
> >>>> channels, which may be used for either immediate reads (same functionality
> >>>> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
> >>>> (same as ADC_TM functionality).
> >>>>
> >>>> By convention, we reserve the first channel of the first SDAM for all
> >>>> immediate reads and use the remaining channels across all SDAMs for
> >>>> ADC_TM monitoring functionality.
> >>>>
> >>>> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
> >>>> ADC_TM is implemented as an auxiliary thermal driver under this ADC
> >>>> driver.
> >>>>
> >>>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>    
> >>> Hi Jishnu
> >>>
> >>> Whilst there are a couple of comments below, I think this is ready to go.
> >>> Unfortunately this is just a few days too late to merge for this coming
> >>> cycle as I need to send the IIO pull request today or tomorrow (due to going
> >>> through char-misc) so this would get no soak time in next.
> >>>
> >>> Also, I'm not sure how we actually want to merge this given close coupling with
> >>> the thermal driver.  Perhaps best bet is I do an immutable branch of next rc1
> >>> once available that we pull into both trees. That would have the first 3 patches
> >>> on it. 
> >>>
> >>> Jonathan
> >>>     
> >>>> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> >>>> new file mode 100644
> >>>> index 000000000000..f8168a14b907
> >>>> --- /dev/null
> >>>> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c  
> 
> ....
> 
> >>
> >> Also, is it alright if I push the next series to address
> >> your comments immediately? Would you be able to include patches 1-3
> >> in the immutable branch you mentioned, once it's available?  
> > It's fine to post a v11.  I'll only be building that immutable tree
> > after 7.0-rc1 is out (or 6.20-rc1 depending on Linus' decision on naming
> > for the cycle that is about to start)
> >   
> 
> It looks like kernel 7.0-rc1 is out now and I had posted v11 here earlier:
> https://lore.kernel.org/all/20260209105438.596339-1-jishnu.prakash@oss.qualcomm.com/,
> 
> so can you please check this latest series and pick patches 1-3 if there
> are no issues?

Sure.  Immutable branch created. However, I'd suggest the thermal folk don't
pick this up until it's had a little soak time. Today I've pushed it out for
0-day to have a look (as part of the testing branch of iio.git). Once those
results come in I'll push it out as togreg and linux-next will pick it up.

https://web.git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=ib-iio-thermal-qcom-pmic5
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git  ib-iio-thermal-qcom-pmic5

Thanks,

Jonathan

> 
> Thanks,
> Jishnu
> 
> > Thanks,
> > 
> > Jonathan  
> 


