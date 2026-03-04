Return-Path: <linux-pm+bounces-43547-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OS8A0H1p2mtmwAAu9opvQ
	(envelope-from <linux-pm+bounces-43547-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 10:02:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7063F1FD10A
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 10:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4996530156D8
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 09:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F40839184B;
	Wed,  4 Mar 2026 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P11c3pKE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MowoujlV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78001A58D
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614974; cv=none; b=T9OIZBMPZyZ6SFnC47OERLJkbJxVhZqVigU+j9li6iw6QE8d8YiokmxkMcb07tuI841eWOX5BsGSujzgUN04wzOVokImSFZ500IZFkMrrxJ4X/A37cQFKSVhJO2uj8TfQJuGt7wId5OG0kiFsReYuk5BGDRp8nL3MTUKURgnZk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614974; c=relaxed/simple;
	bh=vzKg2CmRZRz9tDx8jerfN1FNHIadNDJlHWQvRijQXa4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G6VnVzvvWyB0xlvJBjd9ksHEJrtcV8gKVgJa3QmHxhywYhEu12r+ZPak4ntkLPt5h+V/M7df3M+dgD0J8jA1uYGTFw30Y8KMkjZWsBgqAgPe7OJVV+ddQWPCxcYirD2SBcq+4mcafYJT4PnLaNo7M7VmKL/kIJaw4gksbV1YoTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P11c3pKE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MowoujlV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SV5b945193
	for <linux-pm@vger.kernel.org>; Wed, 4 Mar 2026 09:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=oemXeHFiAD8fwC6Dvlocm0
	aqSqueWx/Mi2JGUCBaDkQ=; b=P11c3pKEW59ZBshwgxJxorRIb/Cvzay+2NGICC
	TUIUByAaAlcJ4kZ2u+UQRh4xlir4oUZ+Q4bGcQlsbPpUNxvswgzYkQGeGnf14P6Z
	cQyRSBvUq28fC5gx6GVvkfsI0fZSqw/uzBYgsGj4SDJoTSWaerzUDMO3bOVZa+GO
	WHl188CFGvZ1icutpN8PmB1fhnMHjGSISUiSpwMVEYdAcjiiBfAlQiuod4toeHcj
	O0r8mK1uDg9SCCe2nZPDDCy7UP7vKNiEqXPDGeazBlvFXHErYyAGTVHX6OMBYVqK
	snkDYFGNPNyWf9q16AhJCZHo6WGOQbvwCO3SUEWD6ILYkaaw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnvxfccut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 09:02:51 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb3d11b913so4158385585a.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 01:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772614971; x=1773219771; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oemXeHFiAD8fwC6Dvlocm0aqSqueWx/Mi2JGUCBaDkQ=;
        b=MowoujlV1gyg3zhOB5PPghswHIK5rZoR0GqX2KF145OEj3cJan+U5t+igXU20ottbT
         BixPxXo5FY3lZzQo+yoQYkbPISYeJLMhUW/EtWuIXA3GeHNwvOlDL0eryzDCb6K9ENwH
         SpFAjxpB70usmzpbUDTTZL52NpPN+Q9WZCjP3Dur6KtoTL3rfOVMCJcGn0fSfgqiC/cE
         kPl5bDfnKBjfjsm2aeDl5NFefA2g8hzldqh4DLxsUUcGm43spdH2Yy4gfJx37rbr8q/V
         BLSKf25oxRYdHzLUwA+MwASHUKo0/yt5c9U2Yg7eqkRwVg8SOvQxnE2cmrkrZtehmT3d
         JWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772614971; x=1773219771;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oemXeHFiAD8fwC6Dvlocm0aqSqueWx/Mi2JGUCBaDkQ=;
        b=re60eSx2mlM7Awvsv3MRmGCMxb/w5IltU4KTaD82A3jIJ+SDeFXdu7uDpf/Kd8SKFI
         S1E4Y8l85Pa42GP6VTev65gPiunn5nHbWD5rH5zuawKxnR/jlp3cGRUJMfnM+aM0Eobx
         PYEGgCPpU+kNboSn2h4fgx3mp/5eyB4QEwJZfew8Kt581sRQTbS8fa7IB6LQbK58DW7B
         x6vWFH/mb8+EexJ4qd1TKqOERDD16wJ2pZMjbawdkcMLCMsRzhU/NlwNK9Ozj4BYNukC
         AoFLiv8QBlBiWVpg89n4xEyoP9DOGFBQm/5ab4527QL/TvWraX8UPf6EHlNYY7VONG3a
         zJpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhYPcrBzssVCDTV5fieTnXPRWznRbA3MSPFae000Qx2bBUhFTFKiouwpKBUYLIxVFCZfogF3CnGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz37PJI0mEK4NJ9CU0hVRvHgTAxifkaqqwXKrw/9CjTBeV2ClRG
	GZYWN/emYiBNwEXWyjv1xmU6piqpReT183u+oH8AKybXYcnsRMcI5dPVsTGqbm7QAWFd7uX5mjK
	xOlp3wxT0/LM/DxKFV375ueKdlVCLniWs2i+4bFOU9MtAFJDQqtc2Lhz5gkTKuQ==
X-Gm-Gg: ATEYQzz20qzgDW2T7xUVetznOk36Ie4aRUY8yMGojF9qIs95caqDLOu8g3+LLXvrkON
	ZGCmgrGA4wGFqbtLnGAILMU9v7yi3ZK1EO75M5d5XFk4VuwFHWqClIePR9Grah+Sse82ebqgEUJ
	Ssr/ltNo13kbn3MEqJfoJWwAPGN/NGbbbLIfkdT1Nro9IU7WmLRUPRQuhAv66GNKKAsknFPyGTC
	2GRJnlc8jG+Okux8tMK27lpoo+kflc7TlS8xm1UoyYiY5pi9bg2tmc4LsxoQOkHrRwgIoJwIR4D
	2pYyTpI6LBce5OCDDC9LiodaGk13SNMbEjgfFiYHa+sB9pXY47tWAaiWe1vKn50V15KspPsGRIF
	/6d+CgpL4V7PGQzW18JPahwcA97sGZiHzmFklU0l4XtNkCI2APAH3
X-Received: by 2002:a05:620a:258d:b0:8b0:f2bd:4762 with SMTP id af79cd13be357-8cd5afd3c5fmr156640685a.75.1772614971115;
        Wed, 04 Mar 2026 01:02:51 -0800 (PST)
X-Received: by 2002:a05:620a:258d:b0:8b0:f2bd:4762 with SMTP id af79cd13be357-8cd5afd3c5fmr156638885a.75.1772614970677;
        Wed, 04 Mar 2026 01:02:50 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:edb0:af14:f4c7:c6ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad02ffcsm3644895e9.20.2026.03.04.01.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 01:02:49 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 00/14] gpio: remove uneeded Kconfig dependencies on OF_GPIO
Date: Wed, 04 Mar 2026 10:02:21 +0100
Message-Id: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB31p2kC/x3MTQqAIBBA4avErBsw+6OuEi3ERhsCJxQiEO+et
 PwW72VIFJkSrE2GSA8nllDRtQ3Y0wRPyEc1aKUn1asB/c2C4vCyEhx7JD3OZGa7GLVAre5Ijt/
 /uO2lfCyoFdRhAAAA
X-Change-ID: 20260304-gpio-of-kconfig-e257ea7c9a09
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=vzKg2CmRZRz9tDx8jerfN1FNHIadNDJlHWQvRijQXa4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpp/UlV7KEbnku5SM6ln9ww7x/7ZvkbRgT9akwX
 ZTKY7PzrYiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaaf1JQAKCRAFnS7L/zaE
 w5VxD/sFAI2igPWylEwWYYIK15BDRKiW+6YYGAfBqLpYl9ZCdmVgeZD06r7JMW6noA5hFzEkv66
 pvwjnkkl7u3DFOw8V3GJsnoNOOowaj6Scqektj5r5FiQwuHc5I8abfSLEsV+V4cO0v7ZKq29NWM
 Slk6AkPOz4Dk9WvQW94bOEYC8bLWudd5dgScZ5sDtsXB2ZVkOU4Un4t2pkX+8AD230La5Ao4gHq
 2nfPT5kU2Ogk9EZLOE66LyX5r1zO/Vj5OAtjgB62Cm3oV01ZLErMP+entT0fo8yY5ScmRMaFpUo
 3lszEgJlDfA1/ZDe7YGcx1Iqfxnt3/YFva8swh9EU9K0fTllltoiemPhEcDsQa5L+CR683lH/5a
 FVYvSL0skiru5EDCrTdHr9OUO3u/OD/twdunXvFtT4F/LzO3iDxvE4CEGqlnI+tyOOv2IzMGGGv
 vbQtrKM8lRKn0N/IC77/tT7IX4aqycoE1lunxb24p/sgoxdJc7e5jEgkPRPmXIOB76VxKbGc0+n
 1F3iiZCY9qL3lsySV+j+61W3cjjIYoI/L5iDJbnwnolQDGAK7PEXv6yL4e4j8aGyXOwDd8Gq1aO
 avM0vTJekP9BWzuxJMN/Y9MbMnlPvTbKHGY0BPgrchdO2JNNJztzOUyRDL4+1lGfij7PFp3V2kf
 qVTMwUWNMgBvbzQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA2NyBTYWx0ZWRfX/IY2f9iReDEj
 UtPe6YYZ0nrOc03OGmw78RPH16smTpC4tjlAAoCXFTchWeORs2ekKiy1gkYrsJUb4vtdPMPvHtx
 VhZrwxpWdRuQXelt+CvrL2kAzehNVg7sxriB3bq8kzknUXRqs26anDzNS0k9HZQiIPL+ZTKn22q
 xZg+UXRFZm/PrXBGLlocXjDUXhXNEAqEwa1WvURrDVTStKNRuEYdMSpXD6fYTUKy4tYFz3F//Kh
 v7qWl4evdMIEuUn+4omvZUozjUFHnJT2TJj/i5VRo7ebASbO1MlPUZiZkLfIcaAm1UVkCJbIaX+
 LNbyBdKUbSiSOZhCMQgaMiVU0/e3QcRcqDlWBqBq0tPtR09sPjvD5FQ2MDbhUS+b9Gm5gh39gHM
 qO1vFcQ9lbrj1aa1ETozBAh5ts8VBnztjje1V2ITd1sfBdP+TxFvtfrm+P49Da1qGxLlMvuDMAr
 mUfFd7fvzSemdGuwaXg==
X-Proofpoint-ORIG-GUID: lt9DKGo2RO9q2E61NlFb_Nq-ZjAWBn-A
X-Authority-Analysis: v=2.4 cv=S+HUAYsP c=1 sm=1 tr=0 ts=69a7f53b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=RbMT-lXscSRh0E1VkaUA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: lt9DKGo2RO9q2E61NlFb_Nq-ZjAWBn-A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_04,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040067
X-Rspamd-Queue-Id: 7063F1FD10A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43547-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[arm.com,kernel.org,synopsys.com,buserror.net,linux.ibm.com,ellerman.id.au,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,baylibre.com,googlemail.com,tibbo.com,roeck-us.net,linux-watchdog.org,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

NOTE: Each patch in this series can be picked up independently into
maintainer trees.

CONFIG_OF_GPIO is a switch that enables the compilation of the gpiolib-of
module. The module itself handles GPIO lookup via the OF-node tree and
is automatically enabled on all OF systems. It does not export any
public symbols to drivers. There is no reason for them to select or
depend on it in Kconfig.

This series removes any such dependencies from Kconfig. If a given entry
has no other dependencies than OF_GPIO - they are converted to OF to
avoid new symbols popping up for everyone in make config.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Bartosz Golaszewski (14):
      arm64: Kconfig: drop unneeded dependency on OF_GPIO
      arc: axs10x: drop unneeded dependency on OF_GPIO
      powerpc: drop unneeded dependency on OF_GPIO
      net: mdio: drop unneeded dependency on OF_GPIO
      regulator: drop unneeded dependencies on OF_GPIO
      gpio: drop unneeded Kconfig dependencies on OF_GPIO
      pinctrl: Kconfig: drop unneeded dependencies on OF_GPIO
      leds: Kconfig: drop unneeded dependency on OF_GPIO
      hwmon: drop unneeded dependency on OF_GPIO
      watchdog: convert the Kconfig dependency on OF_GPIO to OF
      bus: drop unneeded dependency on OF_GPIO
      staging: media: max96712: drop unneeded dependency on OF_GPIO
      power: reset: drop unneeded dependencies on OF_GPIO
      media: i2c: drop unneeded dependencies on OF_GPIO

 arch/arc/plat-axs10x/Kconfig           |  1 -
 arch/arm64/Kconfig.platforms           |  1 -
 arch/powerpc/platforms/85xx/Kconfig    |  1 -
 drivers/bus/Kconfig                    |  2 +-
 drivers/gpio/Kconfig                   | 53 +++++++++++-----------------------
 drivers/hwmon/Kconfig                  |  1 -
 drivers/leds/Kconfig                   |  1 -
 drivers/media/i2c/Kconfig              | 12 ++++----
 drivers/net/mdio/Kconfig               |  2 +-
 drivers/pinctrl/Kconfig                |  9 ------
 drivers/pinctrl/bcm/Kconfig            |  4 +--
 drivers/pinctrl/meson/Kconfig          |  1 -
 drivers/pinctrl/starfive/Kconfig       |  2 --
 drivers/pinctrl/sunplus/Kconfig        |  1 -
 drivers/power/reset/Kconfig            |  8 ++---
 drivers/regulator/Kconfig              |  2 --
 drivers/staging/media/max96712/Kconfig |  1 -
 drivers/watchdog/Kconfig               |  2 +-
 18 files changed, 31 insertions(+), 73 deletions(-)
---
base-commit: c025f6cf4209e1542ec2afebe49f42bbaf1a5c7b
change-id: 20260304-gpio-of-kconfig-e257ea7c9a09

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


