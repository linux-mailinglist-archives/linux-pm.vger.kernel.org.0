Return-Path: <linux-pm+bounces-13371-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A81B969368
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 08:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26154B20A20
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 06:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4127B1CDA2F;
	Tue,  3 Sep 2024 06:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uDOAyzKr"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2352D15575F;
	Tue,  3 Sep 2024 06:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725343631; cv=none; b=kWOy2EDavv6l2q4ytwfj+ZeBWMCa/xCLqNM1r+EM+KTyNloR5l6FG4JnvnMNnzV0yPtatA9Zlzs2c6tYbu44PqEEc+waOVhFVSHpIN7UrbZmv3s9G6boFaMu7bTqnmiLfBSoeINvWlrqUtARnn1tSldWUUfHnbhaBEAOXwtDeuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725343631; c=relaxed/simple;
	bh=539kkzcGlo+tQAl0gprzgy3D6qKVOHdlY2W1Lc3T/fI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szBzYWrKvaVgSQeYPT2SH0P0jSqK2w23K7Uzc30Mk2SJ3g2pJxppyWhGpiQPffB7ImbTJ/Leoi+cfIUKlfPTEbdF8mSAyuDOtPf6fiXXAt7G+h/9Zwou3YVL21jFxjtwN/tqJxZocyMNYgbMiQR+tDPNcyE4gNzT/BKOAqlQOzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uDOAyzKr; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 483672CP012825;
	Tue, 3 Sep 2024 01:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725343622;
	bh=o7Y13VcXEhTIeT0XZuF16cMK0itSnKkJa+trfAbeC1c=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=uDOAyzKrEFaeNaFdN0W8z2/aSsEnutN2I1Ie3wu06ikl612NBqzfZ5Y0KOhnzcT7U
	 NhPclyxEI92ZqJidApqsA0tcPG5RrKoJTySbI/ZwvHXHojOwXJMoQnVenl1jxbYO4A
	 t/gbEwsx3Kr2MPbU7TTILMcMu3sAq7PtNeiD/+Hg=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 483672je069231
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Sep 2024 01:07:02 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 01:07:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 01:07:01 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 483671mW063507;
	Tue, 3 Sep 2024 01:07:01 -0500
Date: Tue, 3 Sep 2024 11:37:00 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Bryan Brattlof <bb@ti.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <vibhore@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] cpufreq: ti-cpufreq: Make the AM625 efuse_offset 0
Message-ID: <20240903060700.ekytq3rj3wz3yw4k@lcpd911>
References: <20240902093222.2828345-1-d-gole@ti.com>
 <20240902093222.2828345-3-d-gole@ti.com>
 <20240902233439.z5kpszcwaswkch6q@bryanbrattlof.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240902233439.z5kpszcwaswkch6q@bryanbrattlof.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Bryan,

On Sep 02, 2024 at 18:34:39 -0500, Bryan Brattlof wrote:
> On September  2, 2024 thus sayeth Dhruva Gole:
> > Since the efuse_offset is basically derived from the syscon node, we no
> > longer need to use any efuse_offset for AM625. This is in line with how
> > the AM62Ax and AM62Px are already doing.
> > 
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> >  drivers/cpufreq/ti-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> > index ba621ce1cdda..98e320832f78 100644
> > --- a/drivers/cpufreq/ti-cpufreq.c
> > +++ b/drivers/cpufreq/ti-cpufreq.c
> > @@ -313,7 +313,7 @@ static const struct soc_device_attribute k3_cpufreq_soc[] = {
> >  
> >  static struct ti_cpufreq_soc_data am625_soc_data = {
> >  	.efuse_xlate = am625_efuse_xlate,
> > -	.efuse_offset = 0x0018,
> > +	.efuse_offset = 0x0,
> >  	.efuse_mask = 0x07c0,
> >  	.efuse_shift = 0x6,
> >  	.rev_offset = 0x0014,
> 
> This may work but it really shouldn't. Unfortunately when I sent out the 
> am62ax and am62px support I missed the .rev_offset and now it's pointed 
> to some random spot in the WKUP_CTRL_MMR space. How it worked on my 

Thanks for taking the time to review.

If by "this" you mean the rev offset, then it's anyway unused. I have
mentioned the dependency [1] in the cover letter where I am using the
revision info based on the socinfo driver.

I have also applied the AM62Ax [2] patches that you'd sent and
tested it here on AM62A [3].

> bench was complete luck (or bad luck depending on how we view this).
> 
> We'll need to pull out a OMAP3 chip and try to separate the OMAP and K3 
> OPN decoding before we can move the .efuse_offset
> 
> ~Bryan

The efuse part of this driver is completely fine, and IMHO doesn't need
any playing with. What does need MAJOR fixing is the rev part of it. I
am wondering if we even really use the revision info to determine what
OPP the devices support in most cases (I am confident that it's useless
for AM62, 62A and 62P). In such cases we should rather even make the
get_revision part optional. I am open to suggestions if there's another
way to do it than what I have done in this series and in the dependency[1].

Looking at `drivers/cpufreq/sti-cpufreq.c`: If they fail to obtain a
version then they simply do version[0] = BIT(major);
If that's acceptable for devices that have revision as _don't care_ then I
can do that as well.

I am also open to the idea of moving the new K3 devices into a
new ti-k3-cpufreq driver if required, to avoid over complicating in this driver itself
with more quirks and legacy vs new SoC differences which exist at
a both SW and HW layer.

Perhaps Viresh/ Nishanth can comment on what they think is the best way
to move forward.

But otherwise,
I don't think these patches are fundamentally wrong or that they won't
work, unless there's something I've missed.

[1] https://lore.kernel.org/all/20240902092135.2826470-1-d-gole@ti.com
[2] https://lore.kernel.org/all/20240826-opp-v3-1-0934f8309e13@ti.com/
[3] https://gist.github.com/DhruvaG2000/d0c360b0bd7e43d0fd28cfe3eab941d2

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

