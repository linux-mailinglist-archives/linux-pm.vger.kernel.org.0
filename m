Return-Path: <linux-pm+bounces-42994-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPWwDfEBnGn6+wMAu9opvQ
	(envelope-from <linux-pm+bounces-42994-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:29:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92219172AC9
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19708303E2E4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 07:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDFF34A785;
	Mon, 23 Feb 2026 07:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IPItmvQe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LhHx0BtW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164B434B186
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771831670; cv=none; b=qivk2Kc4Hq0xetDJtIFbdqrbjWOA6UGY/LtSnd+C3hEj1J9EzcHk+jaYs1kkyJaUQi/F857972BP73Ts3ThXGxbd1AuU7gwvGXY0zQr9oWSzPhrsnJOGK2A5RCfUeEbg8Pu7C9PpVRqSsWh+3bL2+rNtHDe2K30Dhh1DN8dcGEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771831670; c=relaxed/simple;
	bh=S/iCJqcIsf6jSjmWoog3Z0RGxa/CywDCilklRJJyfQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rs8+EYXodRv7fBWnHSmuA157mpf4gl3l6nEV+aZ7l7JBgqJZDDeQf4DpEIhq95OSNDWE1pr5QHITn4K//QSVrAV6CNW/ExsAGRt7xwFbFp/5X1UXfDzQ9TxGS9ptz7ox5iUCRyKWTQJgNJVNoxpcMG87Es6EHOwoaDSRDSaZbAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IPItmvQe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LhHx0BtW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N6PW8E879992
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W2fzDSwRwHz+xfG1K3EDcnND32iTxMHvxjY9VgqhwwU=; b=IPItmvQeYRgcZ6St
	cSFsWNSei9nDwbD0zwAoGiJ/+EN90CsBogIHT5No6AqFSdZ01cXKrLAYGFyfeEkW
	Msujc0HUxPmIL6pesdwMUAL7DFnW7qxTl1iYaViJage1OxE4uzJ6Xm2H5SQ7TCwJ
	LLzTFI4ji+ajN/sQZB1EHSaTVi9uduE+aN324d/J+IhQlHlAVVjqcIYuCr3yL7AU
	kGivsEcIaDhlGm2P47o7o0zhZv2A66P9MMXdeNtGlz3asMpf/4ZdA5GMeOGetK4U
	KfTBuQgwmJcC4PmF2S/pUjbqp5Mgyl8aRsn6EMOdoxmckoZDZ9nUY8An2KqNSoIu
	Q7aQlg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wyurvq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:27:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb3fae6f60so5290559585a.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 23:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771831667; x=1772436467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2fzDSwRwHz+xfG1K3EDcnND32iTxMHvxjY9VgqhwwU=;
        b=LhHx0BtWOfbeR994Si+YeTgt41clSMse+FaF0S2DA1fi1h4fzu2nHe4xVY9FLBI96C
         mLMtkV1MKbtkL6RRHy4GTVVUH7cemD+xdVL/7mGW+l0W7I6DPhCnVRCg//3UZpnKE7bA
         fDl8zgLLrdu8N+8YqLgp08znbJk36Uoj09NGpv+sOuQS9lUi+XBzhToAjuJqRO8LkaH5
         pKYuojKv5PzIa9HPzAKozotJzyncSK0Lc87gYGfkXGwFRSu/hTypHMv7+C3HzsT1hnri
         fmY2RGGdejcunvk6GoRo7KybKl/PM7m9KZNLLOvtSds5Fvvuok5DHdxOXs7P8A1F4ETd
         Gb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771831667; x=1772436467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W2fzDSwRwHz+xfG1K3EDcnND32iTxMHvxjY9VgqhwwU=;
        b=TSdi3ybqqThrGAj7J8pvHYEo+zva12gKM5qPP/gJ0S0esDmPMVe/zxcsb8vil4FvNz
         3Cx6zWhPKPw57Lj2T/CcZGQ46/874gC4U1AHHMY4e+tXggMmY6YRWwjAkzMVTXUSnXkK
         M0LzisOYCWVLH36LDbbRNvMD37x3jYSUq/UUlNB513DUm4yiV/ABRAVuKf+PF1a1nuy2
         5NC8371FrIwZula8LMHwO2oOQGe9J8scTGSw0sVNRyLzmOWnw5smINexWgo2/3rapo/t
         ZHsUFt48BqATUDwv/LuMGVNLDzxE7WGL7ahNN25+/C6IujfsSeBOV0ersXkiTcgqdQ7S
         55/A==
X-Forwarded-Encrypted: i=1; AJvYcCXQpsWIniY3ZdLmoCf9o0GnCthMxlTyOljYKrVpQrY1PZ7raLdsxElhcU9T5k0GGe4Vsopcu4KplQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxS5WMl73enp1ZXV5LkYkE0d13P8ePxnLbPEkzgOXIJhlUhz1Ve
	XM53jXMk6/Ry7ns1cbaRA4Vb1IH7EpfVfbln0Elk8km5s94ROWO5Qojz0UBWTv/fTB175Mc/0F/
	wSCySKAUxDgOi6fOD89bL6m/kheBrjm+FVMfLbETBtB7VtTTZbhD9GVyzHfoEkokY/hRILg==
X-Gm-Gg: AZuq6aIIYQ2Ny1thutV1OjrvmR7ZYXy1o7/qFM6ie6aZJU8pDxxrgiiWOmt9bQcc53L
	2ucB7BqWn03yim+8uo5Tm1PJ109ueleZ7CeHeXRt5aiKvmQWoTbmDyBjT0aim/CuwjvMOWcrtXg
	Alasj7pN92qeiZigqK6U9m6aQ99EiJv4HBkzF8txDv5c1Z8Dq+HTRZk38vs+y91By2wAwUpEf+m
	xRxoWD7XsoCnNHgG4xa3v21ZrzUZBPu2j8UpHj04vxTJ8Wj0uPNwHQgKVm52rFnqbSx+5NOq5xb
	gaj4+cmqS66C1RCaI8OHoKFCdH5aIuc7Hdua41DM/I56psyNgLQPB1hlwiKNcjR8gAZsmndr0ne
	UdLsXIL4oshn6/rVUAvUdnfFtCnJqyyjuirhUygLQCsc4yg==
X-Received: by 2002:a05:620a:46a8:b0:8c7:79d:f91b with SMTP id af79cd13be357-8cb7be3b839mr1530637985a.6.1771831667099;
        Sun, 22 Feb 2026 23:27:47 -0800 (PST)
X-Received: by 2002:a05:620a:46a8:b0:8c7:79d:f91b with SMTP id af79cd13be357-8cb7be3b839mr1530635385a.6.1771831666656;
        Sun, 22 Feb 2026 23:27:46 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9ff5sm18550286f8f.4.2026.02.22.23.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 23:27:46 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 08:27:29 +0100
Subject: [PATCH 1/9] workqueue: devres: Add device-managed allocate
 workqueue
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-workqueue-devm-v1-1-10b3a6087586@oss.qualcomm.com>
References: <20260223-workqueue-devm-v1-0-10b3a6087586@oss.qualcomm.com>
In-Reply-To: <20260223-workqueue-devm-v1-0-10b3a6087586@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tobias Schrammm <t.schramm@manjaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
        Dzmitry Sankouski <dsankouski@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: driver-core@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6407;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=S/iCJqcIsf6jSjmWoog3Z0RGxa/CywDCilklRJJyfQ8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpnAFm0Tv6ZFgGsT5DcytxW+0gXkvsl5c953wDR
 5lE547LmoKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZwBZgAKCRDBN2bmhouD
 1y+VD/9A1ukGl2lbgMZJ7jWzPKBdDezAk1X7RP6OkAEE5aR04FHlqMvjH01rHA5671wAZ/XlLXH
 u0mxgS7a+WxdX+brjZ/EJH3CDYDY1PnBzmm51D9Jh4q2HdSXmDRte5LGtqpE30n8WtWl7eQScl0
 6yByEsaNIgXP4Jdo9Guy25J0mBhZDoVIOWNvRa/bzLXSc++UITkn3XMiGZVh9FejwX+49SFX2Wp
 PcCjEAHZY/dHyK5FjPp/eHzvfgoJDPZ2HkN+C6afRgC/QjCwzPs3CWJiGPZ7fk5HRy3w2TRmQBW
 sBWYAUH+6iQjfgbXKOXx3NLx4aVNmkkQADgy0YbW4tOv0w0I2/lAJZQ32G6C8CEiF14ftblmZ2y
 eCYlYOFnGeCe3wsA2kW2RMlXpRtCM7uhKoZXn9PDKlhFBb/n75UwN49CS19TdoUTzEUgGSCs7yl
 5f0z0lerQLkMBn/9DW446KRVIRSm6qGw2rl1MSK/8LVr2A6xub9WyJX2QIFOqmF1Q2Y6b7z9Z4l
 3ByK6rZe559yCZ69+nPTd0sARnancLikTI6X+im7xlOli+GWtukN1N/X8bVj01O7AVFKFCz7Lbh
 LiP1iXGGm++dc94x5/xy1nPudlf+JCH6nz60rVbtJstGSncuw2Yszo+sj1P/cgsDbZQccWR9u8h
 zIR0pmJMqRGoIdw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA2NCBTYWx0ZWRfX29pJyUdBawzQ
 1D0MbavNxJS/fi80NSfoiauRCPhRU2uKWETt5y8liltHw4qWpHn2klQQVIGF3FdFeEd+0Xq103I
 ELkoTY8BQOzwfok4o64WBiGbzu9VLs87YylxGsjrdfS2m/3XyXCy4V/Jw+wEiLfoW+LZFOMaGIb
 fgumDVnBLN3yfuDQQqzYISrOYJL1axTvJN1QiH40r7FoIyCyXkbYr43SAloOrspVikUmr/UXF8H
 BQDWLq6mrMZLr1Jm5veqSkHGyQFKaHR66Pr3n1ULOK0PdfFe+PPw/KZKRIPwVzVFf+OOQbEj95w
 /pEvF/0ra3T2gfbY7lq+kLS0JpdmX9EnMORlWjw2De3f4Uwlw6Az82/HXsEmbilb0bX5GVGpBcv
 5a0MELcO/PBdx43c9juaSIlmoIHOg+MPlS1wsJkIM5b4gUMYS1IA+LSkk0uR/Eiv51iVQ5YaU+c
 mlUgZgRBdbwdnrWMEoA==
X-Authority-Analysis: v=2.4 cv=UO/Q3Sfy c=1 sm=1 tr=0 ts=699c0174 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Z6KGZMJaPoknz67Z6hIA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: -OLYmEMjSUphZCLZFcsGvXiFQCd_AMgc
X-Proofpoint-ORIG-GUID: -OLYmEMjSUphZCLZFcsGvXiFQCd_AMgc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230064
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
	TAGGED_FROM(0.00)[bounces-42994-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linux.intel.com,linaro.org,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 92219172AC9
X-Rspamd-Action: no action

Add a Resource-managed version of alloc_workqueue() to fix common
problem of drivers mixing devm() calls with destroy_workqueue.  Such
naive and discouraged driver approach leads to difficult to debug bugs
when the driver:

1. Allocates workqueue in standard way and destroys it in driver
   remove() callback,
2. Sets work struct with devm_work_autocancel(),
3. Registers interrupt handler with devm_request_threaded_irq().

Which leads to following unbind/removal path:

1. destroy_workqueue() via driver remove(),
   Any interrupt coming now would still execute the interrupt handler,
   which queues work on destroyed workqueue.
2. devm_irq_release(),
3. devm_work_drop() -> cancel_work_sync() on destroyed workqueue.

devm_alloc_workqueue() has two benefits:
1. Solves above problem of mix-and-match devres and non-devres code in
   driver,
2. Simplify any sane drivers which were correctly using
   alloc_workqueue() + devm_add_action_or_reset().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

All further patches depend on this one.
---
 Documentation/driver-api/driver-model/devres.rst |  7 ++++++
 include/linux/workqueue.h                        | 32 ++++++++++++++++++++++++
 kernel/workqueue.c                               | 32 ++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 7d2b897d66fa..dfc1e85ebfaa 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -464,3 +464,10 @@ SPI
 
 WATCHDOG
   devm_watchdog_register_device()
+
+WORKQUEUE
+  devm_alloc_workqueue()
+  devm_alloc_ordered_workqueue()
+  devm_create_workqueue()
+  devm_create_freezable_workqueue()
+  devm_create_singlethread_workqueue()
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index a4749f56398f..583b0c4bd55c 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -512,6 +512,26 @@ __printf(1, 4) struct workqueue_struct *
 alloc_workqueue_noprof(const char *fmt, unsigned int flags, int max_active, ...);
 #define alloc_workqueue(...)	alloc_hooks(alloc_workqueue_noprof(__VA_ARGS__))
 
+/**
+ * devm_alloc_workqueue - Resource-managed allocate a workqueue
+ * @dev: Device to allocate workqueue for
+ * @fmt: printf format for the name of the workqueue
+ * @flags: WQ_* flags
+ * @max_active: max in-flight work items, 0 for default
+ * @...: args for @fmt
+ *
+ * Resource managed workqueue, see alloc_workqueue() for details.
+ *
+ * The workqueue will be automatically destroyed on driver detach.  Typically
+ * this should be used in drivers already relying on devm interafaces.
+ *
+ * RETURNS:
+ * Pointer to the allocated workqueue on success, %NULL on failure.
+ */
+__printf(2, 5) struct workqueue_struct *
+devm_alloc_workqueue(struct device *dev, const char *fmt, unsigned int flags,
+		     int max_active, ...);
+
 #ifdef CONFIG_LOCKDEP
 /**
  * alloc_workqueue_lockdep_map - allocate a workqueue with user-defined lockdep_map
@@ -568,19 +588,31 @@ alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags, int max_active,
  */
 #define alloc_ordered_workqueue(fmt, flags, args...)			\
 	alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, ##args)
+#define devm_alloc_ordered_workqueue(dev, fmt, flags, args...)		\
+	devm_alloc_workqueue(dev, fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, ##args)
 
 #define create_workqueue(name)						\
 	alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM | WQ_PERCPU, 1, (name))
+#define devm_create_workqueue(dev, name)				\
+	devm_alloc_workqueue(dev, "%s", __WQ_LEGACY | WQ_MEM_RECLAIM | WQ_PERCPU, 1, (name))
+
 #define create_freezable_workqueue(name)				\
 	alloc_workqueue("%s", __WQ_LEGACY | WQ_FREEZABLE | WQ_UNBOUND |	\
 			WQ_MEM_RECLAIM, 1, (name))
+#define devm_create_freezable_workqueue(dev, name)			\
+	devm_alloc_workqueue(dev, "%s", __WQ_LEGACY | WQ_FREEZABLE | WQ_UNBOUND |	\
+			     WQ_MEM_RECLAIM, 1, (name))
+
 #define create_singlethread_workqueue(name)				\
 	alloc_ordered_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, name)
+#define devm_create_singlethread_workqueue(dev, name)			\
+	devm_alloc_ordered_workqueue(dev, "%s", __WQ_LEGACY | WQ_MEM_RECLAIM, name)
 
 #define from_work(var, callback_work, work_fieldname)	\
 	container_of(callback_work, typeof(*var), work_fieldname)
 
 extern void destroy_workqueue(struct workqueue_struct *wq);
+extern void devm_destroy_workqueue(struct device *dev, void *res);
 
 struct workqueue_attrs *alloc_workqueue_attrs_noprof(void);
 #define alloc_workqueue_attrs(...)	alloc_hooks(alloc_workqueue_attrs_noprof(__VA_ARGS__))
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 72a8b64188b3..fd840c46ba55 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -41,6 +41,7 @@
 #include <linux/mempolicy.h>
 #include <linux/freezer.h>
 #include <linux/debug_locks.h>
+#include <linux/device/devres.h>
 #include <linux/lockdep.h>
 #include <linux/idr.h>
 #include <linux/jhash.h>
@@ -5895,6 +5896,31 @@ struct workqueue_struct *alloc_workqueue_noprof(const char *fmt,
 }
 EXPORT_SYMBOL_GPL(alloc_workqueue_noprof);
 
+__printf(2, 5) struct workqueue_struct *
+devm_alloc_workqueue(struct device *dev, const char *fmt, unsigned int flags,
+		     int max_active, ...)
+{
+	struct workqueue_struct **ptr, *wq;
+	va_list args;
+
+	ptr = devres_alloc(devm_destroy_workqueue, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	va_start(args, max_active);
+	wq = alloc_workqueue(fmt, flags, max_active, args);
+	va_end(args);
+	if (wq) {
+		*ptr = wq;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return wq;
+}
+EXPORT_SYMBOL_GPL(devm_alloc_workqueue);
+
 #ifdef CONFIG_LOCKDEP
 __printf(1, 5)
 struct workqueue_struct *
@@ -6025,6 +6051,12 @@ void destroy_workqueue(struct workqueue_struct *wq)
 }
 EXPORT_SYMBOL_GPL(destroy_workqueue);
 
+void devm_destroy_workqueue(struct device *dev, void *res)
+{
+	destroy_workqueue(*(struct workqueue_struct **)res);
+}
+EXPORT_SYMBOL_GPL(devm_destroy_workqueue);
+
 /**
  * workqueue_set_max_active - adjust max_active of a workqueue
  * @wq: target workqueue

-- 
2.51.0


