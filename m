Return-Path: <linux-pm+bounces-43557-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LyoGgL3p2mtmwAAu9opvQ
	(envelope-from <linux-pm+bounces-43557-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 10:10:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5CF1FD49C
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 10:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CE423083031
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 09:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922E1394791;
	Wed,  4 Mar 2026 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D1m8qnvk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RM0EI69t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2959439478B
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615015; cv=none; b=RQnzZmLkfhgZQRGRdyJCbjoXyDgjbuftkyJOOrt+qxfu1L1AIAn2fjnEnxVWOEW1D+YUeg6XT5rmF8SWqEp2ARL1k4SHVW2uWY5Wb8Mdu3/OoPRF1MbCz/axxST2MztBUvsyLOc6laYti9FUpuf1hEXrGtAB6dKwsA1SNCpG/mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615015; c=relaxed/simple;
	bh=ThHFh3NlTGr3cmL2+FqY9w+FucoHGvdn5gmiPzKUOnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uh6gags9Z55N1Cneejq7S54dYu/MLhGliU1BDXWKqKUPmwPaQVdlV99WzqH2uf0va2s2HUEf8AHqxSQcprtaaOMsPs3Tp+uTBFaA4mA6NUcHmtcD06b/MGhahBqby6cKlhnFnRDTktCmRMEKOwxN49NwdBU0mj7oSfWsjYeOoQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D1m8qnvk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RM0EI69t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SSwn3110377
	for <linux-pm@vger.kernel.org>; Wed, 4 Mar 2026 09:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V4DdJrigh17FkqHoOs5hVpX7lVxAfGwxLPSOp0C/QmQ=; b=D1m8qnvk3E5LhfpN
	3QUokB1mBSULrq/CdIG1gvd6CO8eOlzfQSz6frcriPGOVobjPUD7eQqddi0kPWW7
	LbjMvyAguQ0HaBgVtyx93QHvRTCo2bPd84Y4+GvyvQVfYCJse9JhM47kgvuIjenM
	FRAskzPXpM5Dt3drsssUvDqk8KcXz32SAU6JRDHeTbjWrsEhzH1n7L2X9AM29pgR
	1LjrxlnR88mTD7Re2O2hVilruhiy4vGOGYZlcR7J7r78Ipw8TRrAZAlx5CsWP49Z
	8YRrd7Z+1qSFEpv6ae2lephx4GZIpjJNQnokM35jHDfMSE+AT04D4THaXNEr/JkR
	bTADHQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp5h2agvn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 09:03:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb4817f3c8so3722637385a.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 01:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772615012; x=1773219812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4DdJrigh17FkqHoOs5hVpX7lVxAfGwxLPSOp0C/QmQ=;
        b=RM0EI69tKWZZ0NXyeV3zJckgL06pwqG06GAB/3LQ7lxiSCzIHyuEzFfSX7rkaXzhNj
         aU2ojL+vddORnqRH3eu+vnKIpvsGTzSnUvW3rr39DxkJ3Nz7la7oyVdjBf0Eizr/7w6T
         mKigyo+MOYWfFf+JLLbuWSuAK222Qo/yBIcJtt2617wBrXPbk3yyor6J1/kO0aDv1ZRq
         Va5igWc/MmgTEUjoY4L9S++oUqJG3yzOUOOzxu4yEMLb9tkIU/RwqsBeNVw16jho5vej
         jx2YGw2FzW9cWk3IuAAxwcV05I0srdAfCV4UvhAzB9tveWTaJMA3N9KEV32KLfI/o+PN
         YakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772615012; x=1773219812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V4DdJrigh17FkqHoOs5hVpX7lVxAfGwxLPSOp0C/QmQ=;
        b=S83SBjy+TTciLefmRETIU12Ht0ZOseFKm1TU2j9orX6HIZWMF1p246/m+hT/6ATxt9
         KCVcGem6Ogd7k6UIr80Ad2lJCpYwoqFLDUpmrfD8Byrj+8hTQBTLljSS40T6+bMjRhdh
         ld9afvyG858saCJUs8VVAhcUO9smIFsUInVFMHawlHjHaSEpMASniuFZEUcIw2XXiv1a
         RJRhLsgLlq4LkWdIFvdFBeJOaIdHCY+0P6qMFrncYWfJ4iss2uYRUMENsUOJWWOuSTev
         2nzNMXt9pFLjARx1j6yYI2XE5HRF5kpBOxHOOEb+lA/6TNcfqJK9XU224I6jzIZFfcaO
         5kLg==
X-Forwarded-Encrypted: i=1; AJvYcCUjMAaCVaAabJIBhzyhLaoNVBWL6n/B8SPSpcYahaAmGZ856u1ad64euXRx4mDQXrL/3LzR3EWqCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFFkIFtN5RkLBljJwo6iAptS7ofDRGRjAXQOFyZg0C7sBOTNDu
	bKUWVLHvVBF5/4qQReOzJJS3d6Y7LGxz8nXvNV7tOpLUz5SLsIOzxzyHFu90ol21mTNRGK2oM3j
	+gbDyJ0JXk6yJzjFS8jfjqgzLYmScHBEg7MdAgfQejwv1DCMLW7CpB9H6xE80+Q==
X-Gm-Gg: ATEYQzxbk4tdRNaozRceJqV2wFa0l6s5Jx+fHA3EkJo6F1my9AwzYPw8VZrYEQYVl2a
	iBx8JQynY8eeV5/sWw6OIeljDRehxTRsjUmdnZIw5pqh6JfQsoQ2Lyl3L/yhylHuhh71LzxSrtR
	UVdCz7C5fM2oWM+duNA2yGzmalZcRpYt4jGH3Hi7qfNJT8WcmxQLXrHn+yxpZNX6Ja12Rf7HlOb
	plDMUZnBsAeN8x5jVvcGhG1OFMTGJj08k4nmIhtrzPqMgT3mIjK45HwBgvcFDjqivmNINqSI/kD
	dWhrhv1JF6yID1AwIUUO3fECuYmC3NV1QwehjfAvocpbHyCZp8jPn1syWMjTnbu0As5VCqwt1G+
	4pvXiBStkB3GUu1FrBrJyOZDYoW2ec5Y7Esx1lODfhHdtjB3QOZEy
X-Received: by 2002:a05:620a:d8a:b0:8cb:5393:20f8 with SMTP id af79cd13be357-8cd5aebfe1amr147316385a.2.1772615012039;
        Wed, 04 Mar 2026 01:03:32 -0800 (PST)
X-Received: by 2002:a05:620a:d8a:b0:8cb:5393:20f8 with SMTP id af79cd13be357-8cd5aebfe1amr147309985a.2.1772615011499;
        Wed, 04 Mar 2026 01:03:31 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:edb0:af14:f4c7:c6ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad02ffcsm3644895e9.20.2026.03.04.01.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 01:03:30 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Mar 2026 10:02:31 +0100
Subject: [PATCH 10/14] watchdog: convert the Kconfig dependency on OF_GPIO
 to OF
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-gpio-of-kconfig-v1-10-d597916e79e7@oss.qualcomm.com>
References: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
In-Reply-To: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>, Scott Wood <oss@buserror.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-leds@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pm@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=977;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ThHFh3NlTGr3cmL2+FqY9w+FucoHGvdn5gmiPzKUOnw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpp/UzSi5Qn3DgaD6FivvuKNsOUmi1EyHHFH7/+
 rwJ4ztzm+mJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaaf1MwAKCRAFnS7L/zaE
 w2w4D/wLgntjU8j/CxmGWummrsoPSeGrn5cCG8PaCqyxiIKXvDtsH4EKd9slSZb07jfj5yDj1Uv
 Hd8iwoA0IAl6pyIMV8F6C/Le2nEX7Ag7qKCpG7EJ1SGQNamiw0jejArYX8VqkDPB4WQ41l93U7R
 /iOjI+luNjSk9ILZc2s4d1gffEwK0h4ReEorHioIZZJo1QR7SYlvfnspGsytExzS9DaE6BkalDm
 MZLZeaXNysxrzwAkbWhP6fqxo7ce8EhXQzu5U6cyfnjIoKwj4BhY9wQT1vlqcKYu7qwSVCLLwRv
 34dGqURaxeXWUTxumDYguIk0OCt95kbMkJZ7I4gEtIOnoIYXmoE0cXQi7q5eKTHEx1Pdv68JpLm
 xUME2wVPPXUFvYpnkGg9WctfBpmtH0SG0C2Cm9kjCIo++i/NcoGl6yF6nhXUikBqO/r6xnXxM1L
 4i/5PHvnF7c3MgEvaXLjzXmtMjDihQxuFpBA/rXFEgK+cDMLSostTYnJgZaWZWTIqz48EyeBDaE
 3oyY2BMrSsjPTPJvgwUHeksiIYVrTNq30Dy6zjt6d1hl4fWedFAUf3WqvY8s/nfm8xIYBlTZ6i0
 2iigsSnPenUOrcRGMY5Y9N9i6rZROJNbSrXdfQFtt3gUGgfoSeHrntObLfNOa/4G+sndGUQspVe
 1RAylqZe+NoE1Lg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=69a7f565 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=QGo3Xwuj-Fjf7Q_gFxoA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: B2Dl-iGTbrfSMZEE5hIxobN-GYoJE8Bz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA2NyBTYWx0ZWRfX0H+uHx4hFwFt
 lvgQYnXTtGu4d8ejWR46LDPYZ8kkLpPYoGpBvlsdPZMQZcJar2UR1pfz7ve78YHpG/BrrVErptP
 hnBEw3QtrkwY4RTnISq6SdHYRACo6qLXJDqkZ7g8LmFaJwu967y99lXm6Oaz9xUdz2ypTZdZxOk
 /OUWYpC2i1aEQW639JmYEgAg0u73kUY7Lr90sWPD3tvz1HSyUfLmxzD+1gtJIj0qtF1d09iXjeq
 jqa6gnq9Gp0kzAFMCXxRaiQdL7HE+kUyBne4Qe3qJKFYq7q6eYrri4GyYUAKolTMi3K9kn4ZpcS
 J5g3brPhzLDNIGN89aXzxlUEVP51WmlViLhuVZTdLujX4fRicGkxVIlevva+/S/J4WcuAwJ860y
 Yf2lVFuNwQ4lf3gxTAJWvODLGh2Om9x439WZ1cvGloPqvdCjCHnP0IGTriu1LDiTdIyco5+GcR5
 kA6hiSzJV3WWnT3W6+w==
X-Proofpoint-GUID: B2Dl-iGTbrfSMZEE5hIxobN-GYoJE8Bz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_04,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040067
X-Rspamd-Queue-Id: DC5CF1FD49C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43557-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[arm.com,kernel.org,synopsys.com,buserror.net,linux.ibm.com,ellerman.id.au,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,baylibre.com,googlemail.com,tibbo.com,roeck-us.net,linux-watchdog.org,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

OF_GPIO is selected automatically on all OF systems. Any symbols it
controls also provide stubs so there's really no reason to select it
explicitly. We could simply remove the dependency but in order to avoid
a new symbol popping up for everyone in make config - just convert it to
requiring CONFIG_OF.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index dc78729ba2a5d6e035ed3cbe5c2b631d11b76b20..ef200339a22a6f9c51a46c9c0b8466add74313e2 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -250,7 +250,7 @@ config DA9062_WATCHDOG
 
 config GPIO_WATCHDOG
 	tristate "Watchdog device controlled through GPIO-line"
-	depends on OF_GPIO
+	depends on OF
 	select WATCHDOG_CORE
 	help
 	  If you say yes here you get support for watchdog device

-- 
2.47.3


