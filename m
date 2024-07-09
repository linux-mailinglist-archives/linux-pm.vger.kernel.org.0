Return-Path: <linux-pm+bounces-10857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C8B92B70C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 13:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CFAE28196E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BE715749B;
	Tue,  9 Jul 2024 11:19:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E140C13A25F;
	Tue,  9 Jul 2024 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523964; cv=none; b=XzDyhBmeqP3XZM96o7TLzACloGInRh/L+aHPB9rlsMc+eKGA/7G0syVfwwsVkwNKcOddwhQCPsYaXicPJfCpKcs6WmiBS9iAo+RFGBVOp4qmf5kFdhLSv3hnNTIxndwF//Ljvnh+R9NqOEbegGaX5IHB7DYAZzOZ4l4bslnLHKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523964; c=relaxed/simple;
	bh=vssuIFD+QlX736ISqpPBoJNOg/E0YBFJ9cyj3iC5Wzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnnjeJ58LGHk/u7x8TQi4d+5KPQYcETJbZ4pGZ/KkgE+vhQ0i/sLHpyuXjr3gNQwjzWWBS7POkRlyKoA8QrNc5RjhZGAhSFRsUrCfWsOuoxmkaip3OdTSas4co3r7L8MgVv5ixMkWpIgdVtp3/sKtciA+gbZvf0usLYZ76sb5yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DBD3153B;
	Tue,  9 Jul 2024 04:19:46 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F75C3F766;
	Tue,  9 Jul 2024 04:19:17 -0700 (PDT)
Date: Tue, 9 Jul 2024 12:19:14 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Trilok Soni <quic_tsoni@quicinc.com>
Cc: Elliot Berman <quic_eberman@quicinc.com>,
	Sebastian Reichel <sre@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Mark Rutland" <mark.rutland@arm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Shivendra Pratap <quic_spratap@quicinc.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	<linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v5 3/4] firmware: psci: Read and use vendor reset types
Message-ID: <Zo0csvj7-3N2aVl2@bogus>
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
 <20240617-arm-psci-system_reset2-vendor-reboots-v5-3-086950f650c8@quicinc.com>
 <20240619135143.kr2tx4ynxayc5v3a@bogus>
 <20240619080933071-0700.eberman@hu-eberman-lv.qualcomm.com>
 <20240620162547309-0700.eberman@hu-eberman-lv.qualcomm.com>
 <ZnmTtmZB8epgbUTN@bogus>
 <20240702155630416-0700.eberman@hu-eberman-lv.qualcomm.com>
 <1bdc4d4c-9cf1-a8bd-80de-7463cecd2c78@quicinc.com>
 <fadca811-fabd-92b0-0482-c317344de2d7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fadca811-fabd-92b0-0482-c317344de2d7@quicinc.com>

On Mon, Jul 08, 2024 at 08:50:58PM -0700, Trilok Soni wrote:
> On 7/2/2024 4:42 PM, Trilok Soni wrote:
> > On 7/2/2024 4:06 PM, Elliot Berman wrote:
> >> Hi Sudeep,
> >>
> >> On Mon, Jun 24, 2024 at 04:41:42PM +0100, Sudeep Holla wrote:
> >>> Sorry, I completely missed to see that you had already answered those
> >>> in your commit message. As mentioned earlier I haven't looked at the
> >>> reboot mode framework completely yet, so I can't comment on it yet.
> >>>
> >>> I don't want to be blocker though if others are happy with this.
> >>
> >> I think folks are satisfied with the other parts of the series and now
> >> looking for your conclusion on the PSCI driver part.
> >
> > I will be nice to get these patches picked up before 4th July holiday in US :).
>

July 3rd was already late to target v6.11 😉, the merge window may open next
Sunday. Ideally we prefer to have code reviewed and merged before previous
-rc6 so that it spends couple of weeks in -next before the merge. If I were
to merge, I freeze my branch by -rc5 and send PR to Arnd after that so that
Arnd gets some time with the integration of all other PRs.

> Sorry to bug you again Sudeep - but I need confirmation that these patches looks good to you
> and you will pick them up. Thanks.

FYI I am not the maintainer of PSCI. I have given my feedback but I haven't
been able to explore reset/reboot core support in much detail to provide
any further useful suggestions to move the code out of PSCI like I would
ideally like to. But that said I don't want to block this series just for
that reason.

--
Regards,
Sudeep

