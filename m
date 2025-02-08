Return-Path: <linux-pm+bounces-21577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D2DA2D28C
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2025 02:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E6A16CA03
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2025 01:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A86982899;
	Sat,  8 Feb 2025 01:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="EyTlnxcN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m32106.qiye.163.com (mail-m32106.qiye.163.com [220.197.32.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9103B1DDE9;
	Sat,  8 Feb 2025 01:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738977419; cv=none; b=TiTARRADQBfWwbiqrRs+Tdn3B1vHYZxV0Ei/XVJNh5Yk/yADULHV7ZdB5NRiScERBS7FeIbnwaopGbvWYvrs46uzhRv5LPxCowIa/6MctQl97psPdLWGtAbu6lehfIcIR11mAsijuFZdMGQsjOkIK60JRO/pkkmhhG7L1+XZHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738977419; c=relaxed/simple;
	bh=rZxfDjUQ4oAzhda6/Pw6O5ZJKwwEgFhJANAcnJ/L2ao=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sh1MHEI3PyIusLRMPErdckcTiKpyfEFm/SwnrMufwb7y8Xk7srBuGU3anRofnOyWWd5fVNPN/BW8zbRc8bgfphsF0UMi3pKNO/kQB0rPiaEq4qln//9Q8QOm/7MlsU+/ltFFIHhi94YRCi9BwOcOVY+5QaCKu0kQZ77xeGq8lvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=EyTlnxcN; arc=none smtp.client-ip=220.197.32.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id a749478c;
	Sat, 8 Feb 2025 09:01:26 +0800 (GMT+08:00)
Message-ID: <e2f0ecc2-25ba-428b-b643-a33cb6e32898@rock-chips.com>
Date: Sat, 8 Feb 2025 09:01:27 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>, YiFeng Zhao <zyf@rock-chips.com>,
 Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/7] Initial support for RK3576 UFS controller
To: Ulf Hansson <ulf.hansson@linaro.org>,
 "James E . J . Bottomley" <james.bottomley@hansenpartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFq+pWXq75xEtfkeCkmkdZtfp9dAFej4M+6rO6EAUULf=w@mail.gmail.com>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPDyKFq+pWXq75xEtfkeCkmkdZtfp9dAFej4M+6rO6EAUULf=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUsZQ1YeQ0oaQkwZSkpLQk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a94e313640209cckunma749478c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgw6Nxw6CzIRGgMOKCtISz00
	IwMwCxJVSlVKTEhDQkxNT0NDSk5PVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU9MSEo3Bg++
DKIM-Signature:a=rsa-sha256;
	b=EyTlnxcNxHq+jPstL4itjJJIQg0tHEMz7vXUHWhWgZydlK6DNC2yOs/1y2S0Ik4c+2IFQCQfOQDfOimr6dSEyxKQyVRnef5Hqlj41RDl5dfmZvzgJAuYlzCg1FW50hI28Ci3If4ik9ixWAOCJxSWzfzVhJlmh0xsstQQxkRUQEo=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=zqiqX1eIhEi+d4tOiY9PyRcewyPQx3p/Go2zpFzeFK0=;
	h=date:mime-version:subject:message-id:from;

Hi Ulf,

在 2025/2/7 18:17, Ulf Hansson 写道:
> On Wed, 5 Feb 2025 at 07:16, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> This patchset adds initial UFS controller supprt for RK3576 SoC.
>> Patch 1 is the dt-bindings. Patch 2-4 deal with rpm and spm support
>> in advanced suggested by Ulf. Patch 5 exports two new APIs for host
>> driver. Patch 6 and 7 are the host driver and dtsi support.
> 
> Looks like this series is almost ready to be merged?
> 
> If so, may I suggest that I pick patch2, patch3 and patch4 via my
> pmdomain tree and share them via an immutable branch, so they can be
> pulled into James/Martin's scsi tree? Or do you prefer another route?
> 

Thanks for the review. I'm fine with both. Let's wait for James/Martin's
opinion.

> Kind regards
> Uffe
> 
>>
>>
>> Changes in v7:
>> - add definitions for all kinds of hex values if possible
>> - Misc log and comment improvement
>> - use udelay for less than 10us cases
>> - other improvements suggested by Mani
>> - Use 0x0 for consistency
>> - Collect Mani's acked-by tag
>>
>> Changes in v6:
>> - fix indentation to 4 spaces suggested by Krzysztof
>> - export dev_pm_genpd_rpm_always_on()
>> - replace host drivers with glue drivers suggested by Mani
>> - add Main's review tag
>> - remove UFS_MAX_CLKS
>> - improve err log
>> - remove hardcoded clocks
>> - remove comment from ufs_rockchip_device_reset()
>> - remove pm_runtime_* from ufs_rockchip_remove()
>> - rebase to scsi/next
>> - move ufs_rockchip_set_pm_lvl to ufs_rockchip_rk3576_init()
>> - add comments about device_set_awake_path()
>> - remove comments suggested by Mani
>>
>> Changes in v5:
>> - use ufshc for devicetree example suggested by Mani
>> - fix a compile warning
>> - use device_set_awake_path() and disable ref_out_clk in suspend
>> - remove pd_id from header
>> - reconstruct ufs_rockchip_hce_enable_notify() to workaround hce enable
>>    without using new quirk
>>
>> Changes in v4:
>> - properly describe reset-gpios
>> - deal with power domain of rpm and spm suggested by Ulf
>> - Fix typo and disable clks in ufs_rockchip_remove
>> - remove clk_disable_unprepare(host->ref_out_clk) from
>>    ufs_rockchip_remove
>>
>> Changes in v3:
>> - rename the file to rockchip,rk3576-ufshc.yaml
>> - add description for reset-gpios
>> - use rockchip,rk3576-ufshc as compatible
>> - reword Kconfig description
>> - elaborate more about controller in commit msg
>> - use rockchip,rk3576-ufshc for compatible
>> - remove useless header file
>> - remove inline for ufshcd_is_device_present
>> - use usleep_range instead
>> - remove initialization, reverse Xmas order
>> - remove useless varibles
>> - check vops for null
>> - other small fixes for err path
>> - remove pm_runtime_set_active
>> - fix the active and inactive reset-gpios logic
>> - fix rpm_lvl and spm_lvl to 5 and move to end of probe path
>> - remove unnecessary system PM callbacks
>> - use UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE instead
>>    of UFSHCI_QUIRK_BROKEN_HCE
>>
>> Changes in v2:
>> - rename the file
>> - add reset-gpios
>>
>> Shawn Lin (6):
>>    dt-bindings: ufs: Document Rockchip UFS host controller
>>    soc: rockchip: add header for suspend mode SIP interface
>>    pmdomain: rockchip: Add smc call to inform firmware
>>    scsi: ufs: core: Export ufshcd_dme_reset() and ufshcd_dme_enable()
>>    scsi: ufs: rockchip: initial support for UFS
>>    arm64: dts: rockchip: Add UFS support for RK3576 SoC
>>
>> Ulf Hansson (1):
>>    pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()
>>
>>   .../bindings/ufs/rockchip,rk3576-ufshc.yaml        | 105 ++++++
>>   arch/arm64/boot/dts/rockchip/rk3576.dtsi           |  24 ++
>>   drivers/pmdomain/core.c                            |  35 ++
>>   drivers/pmdomain/rockchip/pm-domains.c             |   8 +
>>   drivers/ufs/core/ufshcd.c                          |   6 +-
>>   drivers/ufs/host/Kconfig                           |  12 +
>>   drivers/ufs/host/Makefile                          |   1 +
>>   drivers/ufs/host/ufs-rockchip.c                    | 353 +++++++++++++++++++++
>>   drivers/ufs/host/ufs-rockchip.h                    |  90 ++++++
>>   include/linux/pm_domain.h                          |   7 +
>>   include/soc/rockchip/rockchip_sip.h                |   3 +
>>   include/ufs/ufshcd.h                               |   2 +
>>   12 files changed, 644 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml
>>   create mode 100644 drivers/ufs/host/ufs-rockchip.c
>>   create mode 100644 drivers/ufs/host/ufs-rockchip.h
>>
>> --
>> 2.7.4
>>
> 


