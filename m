Return-Path: <linux-pm+bounces-23341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4660A4D206
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 04:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03941188F45B
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 03:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB11B1DB125;
	Tue,  4 Mar 2025 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iUCFwkmy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA2189BB1;
	Tue,  4 Mar 2025 03:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741058424; cv=none; b=TyvwtXUpnUE8DtVI+uQNnByFSwssO9108HdxYBxDxyXKimW7zFC0m4/wIFeuSPj/U579Q+vt6em1VfPpeIQO4CF4nceRgFXOdTGeVgOpo0Wl2WTUKPWvimpyI5I3Hz6oxJl6JL2v/SHhO0kYGIv7flzQcjC3fQh7hZwr/Ce2/ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741058424; c=relaxed/simple;
	bh=NosbJcn4/Ws+MpSEvLnF6akvk2THj94x8/JVaixVLBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qeBHga0qm7aNaiNQM1Jxyx952f9LoIHOoaLM5WYqf6r7AMn/SlHg8HwELa9HTLwoYl6JNmQT/0JZl6UpnvfGlxw8HtzX2SkmP3u49//uo2Wxkeyxn32Jfb5wlscoGCDYID+ZTrfUfJ5gVHafXgDpDQ4UIy2pRlztyegHPmwFvAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iUCFwkmy; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5241NEDX008950;
	Tue, 4 Mar 2025 03:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TxB1xa4wdylg1sPVhopm7CNcqBs13nJKorqkaF3QfsI=; b=
	iUCFwkmy8HGQcyr+qijHtt+Z9p8MdghPPX5LGrtupntI+UlHbmL3xOpzxT6rbYVK
	fdqGez12MtGXq17nsAtkiaW01ooK4zNBXvzen1igPA2gfR7taVZ7Dhg31C5sA6US
	MSJ6Qa5Mc03FejUEY4pMUm4CKio4ai1/Lf2L1+zdElqESOnFraj5LT9fZZyFBYTN
	v8c9hM77ePlQySfvwlOeI0vWb+mp4/ipR7LFa3ZGj7sJgPzMXQDFKWyh0JR7aIPW
	lbG+mpnW4V6Y/BqFaOhRnyynD3/BFYQzLtwDfT9vriWipAvmhqwCKikIt03MbC5F
	E1bqxKvB13R0JM4g7+VH+Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4541r43vkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 03:19:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52420Tf2039093;
	Tue, 4 Mar 2025 03:19:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp92sh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 03:19:52 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5243Jl4i029873;
	Tue, 4 Mar 2025 03:19:52 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 453rp92set-4;
	Tue, 04 Mar 2025 03:19:52 +0000
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Rob Herring <robh+dt@kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, YiFeng Zhao <zyf@rock-chips.com>,
        Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/7] Initial support for RK3576 UFS controller
Date: Mon,  3 Mar 2025 22:19:18 -0500
Message-ID: <174105384015.3860046.6697292356592676911.b4-ty@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
References: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_02,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503040026
X-Proofpoint-ORIG-GUID: 6Y4eSYXQkMMJQvQlHsmfaECW638UuGXV
X-Proofpoint-GUID: 6Y4eSYXQkMMJQvQlHsmfaECW638UuGXV

On Wed, 05 Feb 2025 14:15:49 +0800, Shawn Lin wrote:

> This patchset adds initial UFS controller supprt for RK3576 SoC.
> Patch 1 is the dt-bindings. Patch 2-4 deal with rpm and spm support
> in advanced suggested by Ulf. Patch 5 exports two new APIs for host
> driver. Patch 6 and 7 are the host driver and dtsi support.
> 
> 
> Changes in v7:
> - add definitions for all kinds of hex values if possible
> - Misc log and comment improvement
> - use udelay for less than 10us cases
> - other improvements suggested by Mani
> - Use 0x0 for consistency
> - Collect Mani's acked-by tag
> 
> [...]

Applied to 6.15/scsi-queue, thanks!

[1/7] dt-bindings: ufs: Document Rockchip UFS host controller
      https://git.kernel.org/mkp/scsi/c/d90e92023771
[5/7] scsi: ufs: core: Export ufshcd_dme_reset() and ufshcd_dme_enable()
      https://git.kernel.org/mkp/scsi/c/6b070711b702
[6/7] scsi: ufs: rockchip: initial support for UFS
      https://git.kernel.org/mkp/scsi/c/d3cbe455d6eb
[7/7] arm64: dts: rockchip: Add UFS support for RK3576 SoC
      https://git.kernel.org/mkp/scsi/c/c75e5e010fef

-- 
Martin K. Petersen	Oracle Linux Engineering

