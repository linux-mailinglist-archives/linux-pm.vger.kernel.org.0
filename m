Return-Path: <linux-pm+bounces-24494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E58A7035B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 15:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2725616C67E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Mar 2025 14:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3757F259CBF;
	Tue, 25 Mar 2025 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RyEaHTQV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649CF259CA2
	for <linux-pm@vger.kernel.org>; Tue, 25 Mar 2025 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912042; cv=none; b=G5IMc5dz/yGjcclVFCcxmZ4kBjNV7vUZO2+CQx5BUQmcFF7yLNrpquRTgUvaJ0oShbaVJYeuXUk6jHIBkwZyFbYc379QpsbdEXWtlX6Z9aFZOD7lxiv3ar/ekgkb/d3L9Rb1WbTeIs2hq3R9nZoHkqk/BNNZgiEUYr3PtBtR7yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912042; c=relaxed/simple;
	bh=HPXVzD0cjy+L3MP8uKMZjV8z7glq9UZzhAChFvp2l2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQSS1ePYoKot6NGWglk72//tLGYOqMvBAzTbcG3AZYv0n3D0rkHu/dU9RWJDG/+ztLWHDtI7PmMDjDAoCXNxgDxj5ODd3sHmrbtViMwQFDfNvd5uUbNhpzDavAZW0SW+8Hs4lr61kW/dpppgCaoGPkUPkB7o7xtAjrbadc0ZGS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RyEaHTQV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PD2Q85026065
	for <linux-pm@vger.kernel.org>; Tue, 25 Mar 2025 14:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6UHGI7B+UO+3MoBOJ7wm4LdCEVBYEGKGFK7sdnFLKk8=; b=RyEaHTQVESZM35BL
	JD9eBXGQBd4rtOQQs+QkZKDbvlLLjXkBbHl62R/WK1Zd0vzRwckyHOGHoUIRerEt
	9IE/GKjW++bFs0HTcyepcbi9u+3VjU1NGWP2uqYiOeEoI/E+0F7vYQ7XyfGZseck
	9zoAfonL61x/MkXAoUOgvuYa5tuU0NH+SPRylxSCUXCNEuoqb8IYDDD+ICpsWUq4
	2qv/+e2HMwHE764D9fUnDfqpyTFhOFifagTOcWhOVH7+j/fbyiuIW4/GPMS8byVQ
	mdPGoVDx/Rc82vBXGNPvom/06iNdoteP4hnhjpSpldqax+p6QsPWrfUzHyGF8khX
	tjbQ2g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hnk8r6b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 25 Mar 2025 14:13:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2241e7e3addso82605315ad.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Mar 2025 07:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742912038; x=1743516838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UHGI7B+UO+3MoBOJ7wm4LdCEVBYEGKGFK7sdnFLKk8=;
        b=G8Zq1LRCKgK703Hjf7iiBSvFOBqPi9RT4tOEBmfYB1W02MVFAH0bGBEAhhM9Hss4bY
         QkAkx9MWOmQFvXVIxnu7E4n9Uf5evTgtz3aN+oywQXb+8Dq3QfosXM4RD9Zwl5ugLSND
         Z37JyVaebQ2iqukOlbjp+eizekFfPbqihJCSqUsTTxfh+V84qaeibwWhC1n1PtTWfvPC
         XAOcenWHXzYC1zu8TMdW3WwKFkDvpWhs0Eas6gCYT0xlX69VKZuljFlDy1GlDzklACjz
         u425x8U0N37CesU0FzxOUbzOyDNCh3RCThBjmaKuVnvzSA6HJeRIy0iRVbzjJgOkjYqu
         nB0A==
X-Forwarded-Encrypted: i=1; AJvYcCVDFTCbjkxNdfa6qB7FzONU6JEGOVuAr8xv2mQfsxFJgyiHqqNii1tV8ai6cWMetukKiKS1+xQQmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcmPC1j4QMvvaglpyozv01CNhWjXXwHhGdIibrH75kevOYdRdU
	U17LJVTGtEif3SJ+BHhtDorOH5h8QSFF1h5QeDnSgiogcmttqV8OEBkyT+DW981QzXaIOvsNkUU
	eC+9RYylP6XIh9KOuDBaIoGO/tpL1quqqpoa1KBJb8areaWLl2cEAqsMaCg==
X-Gm-Gg: ASbGnctFOfmdet5HHJmHJ1ryvtS5obtI8/ufQ9KjjNm+tP8LeUqLynFks23YmKvLAme
	CI6NpMuHj3dv1bC3DaDz94B7/a5tuFuOisRqTCuS3GB0YGk05VQc0bngdE0PgAjHGbMvVX1cZz8
	jzbVCPVycQNXv2/w0jQaWFY+QK0UeRA4xVhheliI5NRQr3QNq1DdduObKJXlQelzLKY1zcEfoK8
	SyJWkok06AS2KVCpwBacOcPP8zXGEcHRPLqWzrEelaAV9hF1xzFZqth3PqbcT7FdPpMHwOhTs2x
	r3gfCFLEQYXyWKteBxpmDQU48Zf/MXW5Y3/gAZxbeXE=
X-Received: by 2002:a17:903:40cb:b0:221:331:1d46 with SMTP id d9443c01a7336-22780c510fcmr226678745ad.2.1742912037407;
        Tue, 25 Mar 2025 07:13:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGctjIt238/axUkoUbQ4QdIvSBgMTmLNz+mz+uulQIJe7SiObWOBp/yOWNe+YRV0y5+EYClbQ==
X-Received: by 2002:a17:903:40cb:b0:221:331:1d46 with SMTP id d9443c01a7336-22780c510fcmr226678135ad.2.1742912036730;
        Tue, 25 Mar 2025 07:13:56 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f45954sm90450565ad.62.2025.03.25.07.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:13:56 -0700 (PDT)
Date: Tue, 25 Mar 2025 19:43:47 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, cros-qcom-dts-watchers@chromium.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Elliot Berman <elliotb317@gmail.com>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>
Subject: Re: [PATCH v9 2/5] firmware: psci: Read and use vendor reset types
Message-ID: <Z+K6G5EuRxnkKYoz@hu-mojha-hyd.qualcomm.com>
References: <20250303-arm-psci-system_reset2-vendor-reboots-v9-0-b2cf4a20feda@oss.qualcomm.com>
 <20250303-arm-psci-system_reset2-vendor-reboots-v9-2-b2cf4a20feda@oss.qualcomm.com>
 <Z9QQw6BcE7IXzu+r@lpieralisi>
 <a9d8d9aa-f63c-481e-b051-a3da0adb3c66@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9d8d9aa-f63c-481e-b051-a3da0adb3c66@app.fastmail.com>
X-Proofpoint-ORIG-GUID: cq14rmM200FUwGfzNCrQ0noZwAKhI1-9
X-Authority-Analysis: v=2.4 cv=KMlaDEFo c=1 sm=1 tr=0 ts=67e2ba27 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=GcyzOjIWAAAA:8 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=um3p_O4XRIyD_4qeEzYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dtxw0mqMjrQA:10 a=324X-CrmTo6CU4MGRt3R:22 a=hQL3dl6oAZ8NdCsdz28n:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: cq14rmM200FUwGfzNCrQ0noZwAKhI1-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250099

On Fri, Mar 14, 2025 at 05:31:44PM +0100, Arnd Bergmann wrote:
> On Fri, Mar 14, 2025, at 12:19, Lorenzo Pieralisi wrote:
> > On Mon, Mar 03, 2025 at 01:08:31PM -0800, Elliot Berman wrote:
> >> From: Elliot Berman <elliot.berman@oss.qualcomm.com>
> >> 
> >> SoC vendors have different types of resets and are controlled through
> >> various registers. For instance, Qualcomm chipsets can reboot to a
> >> "download mode" that allows a RAM dump to be collected. Another example
> >> is they also support writing a cookie that can be read by bootloader
> >> during next boot. PSCI offers a mechanism, SYSTEM_RESET2, for these
> >> vendor reset types to be implemented without requiring drivers for every
> >> register/cookie.
> >> 
> >> Add support in PSCI to statically map reboot mode commands from
> >> userspace to a vendor reset and cookie value using the device tree.
> >
> > I have managed to discuss a little bit this patchset over the last
> > few days and I think we have defined a plan going forward.
> >
> > A point that was raised is:
> >
> > https://man7.org/linux/man-pages/man2/reboot.2.html
> >
> > LINUX_REBOOT_CMD_RESTART2 *arg command, what is it supposed to
> > represent ?
> >
> > Is it the mode the system should reboot into OR it is the
> > actual command to be issued (which is what this patchset
> > implements) ?
> >
> > LINUX_REBOOT_CMD_RESTART "..a default restart..."
> >
> > It is unclear what "default" means. We wonder whether the
> > reboot_mode variable was introduced to _define_ that "default".
> 
> I think the reboot_mode predates the 'cmd' argument: linux-2.1.30
> introduced LINUX_REBOOT_CMD_RESTART2 and it already had
> the warm/cold/bios/hard options for i386 reboot. I think the
> argument went unused for a while after it got introduced though.
> 
> > So, in short, my aim is trying to decouple reboot_mode from the
> > LINUX_REBOOT_CMD_RESTART2 *arg command.
> >
> > I believe that adding a sysfs interface to reboot-mode driver
> > infrastructure would be useful, so that the commands would
> > be exposed to userspace and userspace can set the *arg command
> > specifically to issue a given reset/mode.
> >
> > I wonder why this is not already in place for eg syscon-reboot-mode
> > resets, how does user space issue a command in those systems if the
> > available commands aren't exposed to userspace ?
> >
> > Is there a kernel entity exposing those "modes" to userspace, somehow ?
> 
> Don't know one either.
> 
> >> A separate initcall is needed to parse the devicetree, instead of using
> >> psci_dt_init because mm isn't sufficiently set up to allocate memory.
> >> 
> >> Reboot mode framework is close but doesn't quite fit with the
> >> design and requirements for PSCI SYSTEM_RESET2. Some of these issues can
> >> be solved but doesn't seem reasonable in sum:
> >>  1. reboot mode registers against the reboot_notifier_list, which is too
> >>     early to call SYSTEM_RESET2. PSCI would need to remember the reset
> >>     type from the reboot-mode framework callback and use it
> >>     psci_sys_reset.
> >>  2. reboot mode assumes only one cookie/parameter is described in the
> >>     device tree. SYSTEM_RESET2 uses 2: one for the type and one for
> >>     cookie.
> >
> > This can be changed and I think it should, so that the reboot modes
> > are exposed to user space and PSCI can use that.
> 
> Can we try to call them 'arguments' rather than 'modes' while discussing?
> I think it's way too easy to confuse them otherwise.
> 
> >> +	psci_np = of_find_matching_node(NULL, psci_of_match);
> >> +	if (!psci_np)
> >> +		return 0;
> >> +
> >> +	np = of_find_node_by_name(psci_np, "reset-types");
> >> +	if (!np)
> >> +		return 0;
> >
> > Related to my initial question above. If LINUX_REBOOT_CMD_RESTART2 *arg command,
> > is the actual reset to be issued, should we add a default mode "cold"
> > and, if SYSTEM_RESET2 is supported, a "warm" reset mode too ?
> >
> > It all boils down to what *arg represents - adding "cold" and "warm"
> > modes would remove the dependency on reboot_mode for resets issued
> > through LINUX_REBOOT_CMD_RESTART2, the question is whether this
> > is the correct thing to do.
> >
> > Comments very welcome.
> 
> It would make some sense to me to treat all psci reboot as "warm" and
> not do anything here if reboot="cold" is set: those would have to
> be backed by a hardware specific driver.

The patch implements PSCI SYSTEM_RESET2 vendor reset types which seems
independent of reboot_mode (warm/cold/etc) as per specs.  As per ARM
PSCI SPEC:
https://documentation-service.arm.com/static/60feb9bf3d73a34b640e1b67%3Ftoken%3D&ved=2ahUKEwiX7ramjZCGAxUXrlYBHaPaBX4QFnoECBUQAQ&usg=AOvVaw1L35eQniULNRstfGKX5KXp

quoted from spec: -- 

""
5.1.11 

SYSTEM_RESET2 This function extends SYSTEM_RESET.

It provides:
	• Architectural reset definitions.
	• Support for vendor-specific resets.

Bit[31] Reserved must be zero. 
	o Set to 1 for vendor-specific resets.
	o Set to 0 for architectural resets.

Bits[30:0]
	o For vendor-specific resets, the format of these bits is IMPLEMENTATION DEFINED. 
	o For architectural resets, the following values are defined:
		- 0x0 SYSTEM_WARM_RESET.
		- All other values are reserved.

""

So, for vendor specific reset types it does not specify warm or cold.

-Mukesh

> 
> A related problem is how to determine when to use UEFI reboot: at the
> moment arm64 tries the UEFI runtime interface before it even attempts
> any of the notifiers, so PSCI reboot won't ever be used if UEFI is
> present.
> 
>      Arnd

