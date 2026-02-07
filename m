Return-Path: <linux-pm+bounces-42252-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK4BDdhuh2nQXwQAu9opvQ
	(envelope-from <linux-pm+bounces-42252-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 17:56:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A69106958
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 17:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EE253013A62
	for <lists+linux-pm@lfdr.de>; Sat,  7 Feb 2026 16:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B9C3385A3;
	Sat,  7 Feb 2026 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtS+6E94"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C5828E00;
	Sat,  7 Feb 2026 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770483411; cv=none; b=UEFAsGj1PsKuUT2gPeTrJ3tgU/eyvhLvy+cQv7rfaVJeWVwTm8z699j7X1vCEV0Alej2ZPkv7VY4DAE254k2wpS5MKCyeGSVuv6jqb0A86C6WLnDZ5M7op/TqW7vpeNpj4xbqmLfksSI7DKXHCq1YF4z1esmRB/Pt+IRF6+fWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770483411; c=relaxed/simple;
	bh=IrImk1bQuL9qmSWx9DsD2lEvSHiTsM67+rBMdJC3LUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRTP5SC0svg6nZKJrzs0Bie+fNkHSpxhRWDeGSjc59BqcPQnwW4sf1tN/Vpv/bZMJMPRH3oTM+wtKHmClS+jJ3lEiMmjlWI47r6rsMGEXOrgLlMckHfwrMQYQcwb5pqJ9ps41Oy1C/M7ynmvgdmcOUB4UgSUckGJ2xCCHOnqX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtS+6E94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C47C116D0;
	Sat,  7 Feb 2026 16:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770483410;
	bh=IrImk1bQuL9qmSWx9DsD2lEvSHiTsM67+rBMdJC3LUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UtS+6E94Wz0W4EWD7pF7X6eGfGztm2Wv81CUSiwmVuyxzPznhZB5V59QqqL5+oaNi
	 Xd8uY0eSA9n0BzNyN+Iwm5Dgd2SR5cQOKzteBWTwqMfPVf0AmYIQo8y5mPh879Gs4s
	 PNGVHQnhyUAllMRk73KxL3XBJdNuEdkeBwlFxgs5sIr8O305IijBtv/qPOWMvckgcF
	 jW30IBYXfD2xXN5FTLmJHujWjeh4gcX5h63TA/cXA8hILBnaO9OCB3N2P/qDjSTvuh
	 XGVShVoAjRbbwI1wyb5ibGw9OO38mJZzSkM5l3rQ7R5micXThDg5nN46XKW5AIZiOc
	 f4qHh1m6CIetw==
Date: Sat, 7 Feb 2026 16:56:38 +0000
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
Message-ID: <20260207165638.0ed27302@jic23-huawei>
In-Reply-To: <6012ad64-3a10-4f05-9f37-f2d0c36df582@oss.qualcomm.com>
References: <20260130115421.2197892-1-jishnu.prakash@oss.qualcomm.com>
	<20260130115421.2197892-4-jishnu.prakash@oss.qualcomm.com>
	<20260131173941.68b8116d@jic23-huawei>
	<6012ad64-3a10-4f05-9f37-f2d0c36df582@oss.qualcomm.com>
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
	TAGGED_FROM(0.00)[bounces-42252-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 86A69106958
X-Rspamd-Action: no action

On Fri, 6 Feb 2026 18:45:02 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Hi Jonathan,
> 
> On 1/31/2026 11:09 PM, Jonathan Cameron wrote:
> > On Fri, 30 Jan 2026 17:24:20 +0530
> > Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> >   
> >> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
> >> with all SW communication to ADC going through PMK8550 which
> >> communicates with other PMICs through PBS.
> >>
> >> One major difference is that the register interface used here is that
> >> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
> >> There may be more than one SDAM used for ADC5 Gen3 and each has eight
> >> channels, which may be used for either immediate reads (same functionality
> >> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
> >> (same as ADC_TM functionality).
> >>
> >> By convention, we reserve the first channel of the first SDAM for all
> >> immediate reads and use the remaining channels across all SDAMs for
> >> ADC_TM monitoring functionality.
> >>
> >> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
> >> ADC_TM is implemented as an auxiliary thermal driver under this ADC
> >> driver.
> >>
> >> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>  
> > Hi Jishnu
> > 
> > Whilst there are a couple of comments below, I think this is ready to go.
> > Unfortunately this is just a few days too late to merge for this coming
> > cycle as I need to send the IIO pull request today or tomorrow (due to going
> > through char-misc) so this would get no soak time in next.
> > 
> > Also, I'm not sure how we actually want to merge this given close coupling with
> > the thermal driver.  Perhaps best bet is I do an immutable branch of next rc1
> > once available that we pull into both trees. That would have the first 3 patches
> > on it. 
> > 
> > Jonathan
> >   
> >> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> >> new file mode 100644
> >> index 000000000000..f8168a14b907
> >> --- /dev/null
> >> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> >> @@ -0,0 +1,860 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> >> + */
> >> +
> >> +#include <linux/auxiliary_bus.h>
> >> +#include <linux/bitfield.h>
> >> +#include <linux/bits.h>
> >> +#include <linux/cleanup.h>
> >> +#include <linux/completion.h>
> >> +#include <linux/container_of.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/device.h>  
> > If you happen to be spinning again for some reason, I think you might be able to replace
> > this device.h include with a forwards declaration of struct device;
> > 
> > If you can that would be good as we are trying to reduce includes of these
> > mega headers.  
> 
> I have a query about this. From what I understand, having a forwards
> declaration of struct device may be valid if we only use the device struct
> definition directly, but not if we try to dereference any of the struct's members.
Ah my mistake. I missed the dereferences!  You are correct to include
device.h.


> 
> I see that at some places in this file(qcom-spmi-adc5-gen3.c), we dereference
> the device's parent:
> 
> 
> One example:
> void adc5_gen3_mutex_lock(struct device *dev)
> {
>     struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
>     ....
> 
> 
> Another example:
> static int adc5_gen3_probe(struct platform_device *pdev)
> {
>     struct device *dev = &pdev->dev;
>     regmap = dev_get_regmap(dev->parent, NULL);
>     ....
> 
> We do not dereference the device's parent in the other new files
> (qcom-adc5-gen3-common.h and qcom-spmi-adc-tm5-gen3.c), so
> I can drop the device.h inclusion and use a forward declaration
> of struct device in them.
> 
> 
> In this file, what would you suggest I do, keep or drop the
> device.h inclusion? 

Keep it here given the dereferences you pointed out.

> 
> I do see that device.h is included in auxiliary_bus.h,
> iio.h and platform_device.h, so chances may be low that
> it is somehow dropped later from all of those files and
> will need to be explicitly included here.
> 
> 
> Also, is it alright if I push the next series to address
> your comments immediately? Would you be able to include patches 1-3
> in the immutable branch you mentioned, once it's available?
It's fine to post a v11.  I'll only be building that immutable tree
after 7.0-rc1 is out (or 6.20-rc1 depending on Linus' decision on naming
for the cycle that is about to start)

Thanks,

Jonathan

