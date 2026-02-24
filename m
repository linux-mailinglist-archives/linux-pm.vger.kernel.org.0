Return-Path: <linux-pm+bounces-43101-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHJNGXRInWk7OQQAu9opvQ
	(envelope-from <linux-pm+bounces-43101-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 07:43:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B76AF182822
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 07:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01A1530314FD
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 06:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040073093B8;
	Tue, 24 Feb 2026 06:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C/7sh+F6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cN6BjzD4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA24930594E
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 06:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915359; cv=none; b=WmibbfvrpWP1xXIZl+vZuXNsCWDE8RkXnfhk5Kk38W6G5w+XTqR6w1eaMA+Xm9xLkFNTOYBKPgLRfRjikOwXVVcdsiSCfLbC/da47/ojfHN39R7f3bChBHoF/pEXiSNdTJAtDeORWtrzAjyP8cLuCGJDm1Dyp7zeyOhnE1Gw/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915359; c=relaxed/simple;
	bh=PdSzz0bj4RkAm9gUU9i1xAXXLdjyg5Gspl8Tfkihp6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h/y3/CiFi7P2qwB5MBUwMC9SwO7f3+ovdXq/IJqWsTtsWQ7DQEHOifFWMAFtLy5joMlQpAANnUWjB5YClkdW5l8Z4Ww9nYRMLgEpS6xC842I4DSsGlq2KHMlNbTGHjpj3SQ4H10Eus1o5jBlNM6jjDEs4jjti3Atm3f4LzHA1XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C/7sh+F6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cN6BjzD4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O4LxpN2809079
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 06:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oHUkWHA7HOd0fTIofvIxhQ4B2OX1P9ypBZz5EM2pVT4=; b=C/7sh+F6t6c7mNZH
	LOENAoK2g9gdWxr35Ubb9rvP1Uyz7uCLyk73zjCdkBTCTeREdm5SU7B0wEtt2Cbl
	ATMYUGG8XMMg6ZK2r27bi2MNOZvOoXsrBqretJ4AX7wsgFSZM2Ra7RIoSaieVTrU
	+erRVB/iY6Yq+hhT/fw/3sAbID5pQJr6BZQ+rV0OtC9m3nZ/hroZXyi5IMQBejUT
	r/gjjiNMOR5Jl6RGJhu8P8/+zv5wLfx9btl74Ag6nrCdCoyc45ckkLgqhmHPIVxr
	KHj+08cNw0AQteiWsuqMTu8GOVKFoKmgNHjlMuQDmoEBkuWJp8He7Bo7aH3TUq5k
	bzZiEw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8rb6fm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 06:42:37 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-824f75913c4so2366928b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 22:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771915357; x=1772520157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHUkWHA7HOd0fTIofvIxhQ4B2OX1P9ypBZz5EM2pVT4=;
        b=cN6BjzD4VHiYhfriXHme/W0T+4jIL46tNlC5SVsIdgjTMtqvysyIb7dnoh/ZVip1Sx
         IG0pcebDYwMl3iermqGyALcnLkKNzCT72+hRQLE4170SGqAIHu27h0hwS9ayINCb92pl
         VIOS39609bA13ybNOQs7gCBqOQR97HrpmLrBn4NEk3058mWxGQ0ROoyyelU3VAyBQtcr
         vijP9TK9+nhglqRr8DqEqASVl+K8qO0/RW9MIl0aIkmcuiyecfuqGzlRNbQkgAMYtMCm
         loKA+I1lqvtBMunlPn9fVbL/cJcYGUp1PBHea7XMs5//DtilM3G3ZwUdQ/BbUjgl7OTX
         yYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771915357; x=1772520157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oHUkWHA7HOd0fTIofvIxhQ4B2OX1P9ypBZz5EM2pVT4=;
        b=CY8EFWg6TDEv2QpBYujRJFrww1HubvZiNqvB5BriSVnaSBjXDT0BQn01PrK/9ETRLX
         4WzyRK+aQWRNIwKCxHPfpqw1t0Cx1Gk2HLj9YFMaonmU3gmrz2fixtapnf0awHMYHvQE
         I1Le24yKCiDcRCRel3+ABzVKRgQO7+1uiq5qWojNymjpYCZZz/SY2OUO0CL3yVs9tqD8
         wQNzm9BiIIJHSdQOcYG3DEtnff74MOKpxYdPwXrc5JCDTGHxGJNDdoYONzoIX3ju2ss+
         JRe6dP09AiXklGVULmo+rCtXhIiacBEkT3qmER30Q1ehZ3uOcPy2zHpIOr/Ajt/OZftR
         30Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWvSNRyY+9SQEpx45VzV4Js1cC6MKJmS/KMycAsQ41lKuCpJGLagA+JK2ewjZJLXcX3hGYpDjsIbg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3aNej6cRUdf94TzuEqdxs3S2CZeOw/ZkSwtAC/9/Y/6uRMv3R
	Rv/dA1wwziJe3DAsUY8xFc0qq+tN2nxCQATRMnIgaUnswULF4y7p1JLpnCRxYXChyexiypca4//
	cSC88QXX16gsuL7kvJGGIxO8L6s3fiCtJqxaPxes8pVICxnrrA5d4aedE+IJAjw==
X-Gm-Gg: ATEYQzwD46gYid2LEwVKmDPa2J2N6e0lm7VuHK3+wxkP0OCPaGcdIyHCmKphUg4Md6M
	1ZMe1EyjBpkyrK4Cp2rfS36rVGge+CZlsIAd+JCt5VCpYpTNIMKHio+1zzinlBRzwmev7LkTMdD
	/J6uzn9d8IOvUl7jHVDrQz0hRJy1enPC2XvWT3fTieKWWUpHdgkue8/Me0+GkfKOPW63vfk4xiK
	nVSVI0OIenui7+ifis8AK3+lhhzwgCQBnwNysFIEhAkNzcrz5OSLTCh0JtuGdHbrARF17f5jWUj
	GtaVe0G3EeK+Z6yotaJtlb/ET20Tx4HBnkjxlYzSkvnPfRAhcU/PAO4XHV3HjPQMRroUOS+20nI
	Q5aIyUXZEeZat/0S2ULIFDcvtBplLKlJHxy3CPvU9T44qccy4AldB+nCWAg==
X-Received: by 2002:a05:6a00:23d2:b0:81f:4a0c:c584 with SMTP id d2e1a72fcca58-826da8bf420mr8944998b3a.1.1771915357187;
        Mon, 23 Feb 2026 22:42:37 -0800 (PST)
X-Received: by 2002:a05:6a00:23d2:b0:81f:4a0c:c584 with SMTP id d2e1a72fcca58-826da8bf420mr8944979b3a.1.1771915356677;
        Mon, 23 Feb 2026 22:42:36 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8c7535sm11857732b3a.56.2026.02.23.22.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:42:36 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 12:12:26 +0530
Subject: [PATCH v24 1/2] Documentation: ABI: Add
 sysfs-class-reboot-mode-reboot_modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-next-15nov_expose_sysfs-v24-1-4ee5b49d5a06@oss.qualcomm.com>
References: <20260224-next-15nov_expose_sysfs-v24-0-4ee5b49d5a06@oss.qualcomm.com>
In-Reply-To: <20260224-next-15nov_expose_sysfs-v24-0-4ee5b49d5a06@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bgolasze@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771915349; l=2327;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=PdSzz0bj4RkAm9gUU9i1xAXXLdjyg5Gspl8Tfkihp6c=;
 b=H6a3q9ynFdCwo5wpTqcHf5538fqn73/13OZdKErzfYNcjDDmjyLtPqStq0rg9px0DnKCAxID3
 Hh7skNuRg/lCIFVGTJaBVf4cwbIJEfBLWke7TAsD6yxHI3FctC7bAk1
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: 5oqm2dBEtVpMRc43dpdWZEqQS-_zNDZI
X-Authority-Analysis: v=2.4 cv=V7twEOni c=1 sm=1 tr=0 ts=699d485d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=LKyF0dicRlewKW4vAhwA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA1NiBTYWx0ZWRfX4wZrh6MGW8cT
 HWCqcdaiNKPuCtkGBjkgPNZ0NZ7nYv1pqT1rV3rD/GdxAv7HyujV94YiMbhupxpaC2SXUHfAXZo
 Ja4odtu9QOj7zclSXmVMKYRyAOr13wN78yeUw1kZ7qiDoL2ShGYFUqVUemAAibhiApHYnX0Tmt9
 r7lJjhLzcEASZIdPxAYyxeM1tbwC5Ok3i24/kk6f4iyAX0hPtSPskUxo+dn4GAeHUB+aHe8F+SI
 Y6SXoYUp0Ob/+3qgHyVBsWkjlbYX9b7+ZI65FritQ9PYHsy4T7HbZpLCcnLALi/sbQhtTXT3H/R
 TQ6oV4xDRiddJJeA0JQQmyhWv3dbZUZIURzSgcg9jlC1/sWlRMKPEB83H39TDq8LRmsIQJpfmoQ
 RV8cqvKFNDypGP9T6SaCXkgS6efLMDaZvnqX5FP+zEcNasQMGInijtlFJFu1hW6CwH6wui1tZ+u
 uWB1D2qLEIBuQSC/inA==
X-Proofpoint-GUID: 5oqm2dBEtVpMRc43dpdWZEqQS-_zNDZI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240056
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,collabora.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43101-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FROM_NEQ_ENVFROM(0.00)[shivendra.pratap@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B76AF182822
X-Rspamd-Action: no action

Add ABI documentation for /sys/class/reboot-mode/*/reboot_modes, a
read-only sysfs attribute exposing the list of supported reboot-mode
arguments. This file is created by reboot-mode framework and provides a
user-readable interface to query available reboot-mode arguments.

Reviewed-by: Bartosz Golaszewski <brgl@kernel.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 .../testing/sysfs-class-reboot-mode-reboot_modes   | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
new file mode 100644
index 0000000000000000000000000000000000000000..a16c54ab841bb4687d3844ac5dd4abf6b37326e1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes
@@ -0,0 +1,36 @@
+What:		/sys/class/reboot-mode/<driver>/reboot_modes
+Date:		March 2026(TBD)
+KernelVersion:	TBD
+Contact:	linux-pm@vger.kernel.org
+		Description:
+		This interface exposes the reboot-mode arguments
+		registered with the reboot-mode framework. It is
+		a read-only interface and provides a space
+		separated list of reboot-mode arguments supported
+		on the current platform.
+		Example:
+		 recovery fastboot bootloader
+
+		The exact sysfs path may vary depending on the
+		name of the driver that registers the arguments.
+		Example:
+		 /sys/class/reboot-mode/nvmem-reboot-mode/reboot_modes
+		 /sys/class/reboot-mode/syscon-reboot-mode/reboot_modes
+		 /sys/class/reboot-mode/qcom-pon/reboot_modes
+
+		The supported arguments can be used by userspace to
+		invoke device reset using the standard reboot() system
+		call interface, with the "argument" as string to "*arg"
+		parameter along with LINUX_REBOOT_CMD_RESTART2.
+
+		A driver can expose the supported arguments by
+		registering them with the reboot-mode framework
+		using the property names that follow the
+		mode-<argument> format.
+		Example:
+		 mode-bootloader, mode-recovery.
+
+		This attribute is useful for scripts or initramfs
+		logic that need to programmatically determine
+		which reboot-mode arguments are valid before
+		triggering a reboot.

-- 
2.34.1


