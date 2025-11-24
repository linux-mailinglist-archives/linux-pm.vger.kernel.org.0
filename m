Return-Path: <linux-pm+bounces-38456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E83C8023D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A9654E4FBC
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05892FD670;
	Mon, 24 Nov 2025 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tr5M6zu1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NqgFuCcY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5292D2FCBE3
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982770; cv=none; b=PF0I7QlGTsT9+kOO53hVx5vsp0F2+mVO1TJJiU1LBOyXkdpSlApQF2rX9sYNw+awbB8U7FhQ1Lmc1Aif9kPEcuuUxBz2/0+Og8Dnx862MgqUeXRQYw5P5TwIsvcXrwK79/utku7e37GmQAPmizv+uxjfvTHg2/ooC4vjGbaWZfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982770; c=relaxed/simple;
	bh=GXzOHUcu8jmVZSISxvrMjghCvNltj3MFWdbS2tT+y0c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YrXlBH8d5MxwZolGzF9sCObyDGg5y8x7if6uaOvQpLEzH93xH01Cze1JAlJ7LGW8har+98td2Hfj5EQC52X4k/EdVMgIkl9Kxt4XsGYeDf7o9ge6UeogRoGvn0Tqt36NGpF4zejNKi7WzJJ4iItcIcYvp/q7fhnviV4rEia5Df4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tr5M6zu1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NqgFuCcY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AOB5p7o4003293
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 11:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TXqbpIEBiec+YdCd2w7Tb/
	wyyfHy7fnw5FPr5MJIDlw=; b=Tr5M6zu1+RTGZczxCJO4GmMG1wEzJL1/NcgYGu
	5OzHOf1+stA/JUfwI8LQ3ALXKOrJiB+eP6NT9FENyO0lmthYvyUVekYGj0eXzuMD
	JwqoZsdEkz4IndBCCQ3Ag706mlOYFlsA0RvDxqqLGWwSf8zWstcz/yh5n4RyoSG6
	/MfsIxXj1eFi0C8dNivA55qh1EByVwKfPo2A73HsbJ1ou6HPF91xm/VcLa7J6y+t
	q+DeQlfL+N4eBsw+voKTanCP97fuTXwPjldZiQa58+DRm8jPomwlcivS7IW0aLeZ
	iL/kg0Mw4nUdvob0Zi+d5a6Wd8TkZlxAKKWuV7wKWPKGY3DQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amp6h00qt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 11:12:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7ba92341f38so4237628b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 03:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763982768; x=1764587568; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TXqbpIEBiec+YdCd2w7Tb/wyyfHy7fnw5FPr5MJIDlw=;
        b=NqgFuCcY+jsd8b2AH85JyVTao5iRY0hwzC83bcuUbbSaURCRqh0dbMY9qtwbov8jkF
         lLTEoS4p5tgzK/pTTP3B7znQL9mJCHkGlsqMge0WHtdVEew6F1tOJc2H7PTaI8OO1guy
         M7BKiPcPoz1GKESph5RD6unwX8yS73B1KUSgwcOTnnZhIKLu8gPVjvB82/JKZIUzTob7
         OgiDBZkFh6Zqyc3AW/tMNrGnWRKOUqXMh8RtDneoWI5ZA7wfrCfTDJVPeWFW13xoZ4Ad
         vf6ZJ9xiVkyE/SvOJ8GZ4eG9l5oK/9kV4BQx2LkMPzFT8JnSGN5BLhY0pnfenmuNvdrw
         3Nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763982768; x=1764587568;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXqbpIEBiec+YdCd2w7Tb/wyyfHy7fnw5FPr5MJIDlw=;
        b=SCcCODpJbaOJkvNChl0jw9rCFd70hMe8rL2IGXU7tp66HIn7I5Ax/koMvs+Zm6wX/+
         DfBtQK0ZzLTzmoO6gx9yYeadGbXbnhq+TCsULhKzvzBHLP1NGGKTLOLsbbvzh1XylToP
         PqX4Jr9Ips1eT6aO3cwdAd/oQx1gWiasOa5fVXjll8pRy3oeeWtw9B3CrVlqrFWn9mff
         HQ52DZ91pDZE1oHI8ZUpI5uF5XAqjsKEGVff+NZFdO6et1CuhIeOAO1jEm2J8P4D3yfI
         sq9/K7jcjJAmBrXm++k1spw6WLIPQ5lkSQgfFlVNo6KWB/Fz0dslKBwAUlqbGPl3rVn2
         gw6w==
X-Gm-Message-State: AOJu0Yz1wi54Qo0mLzsMMUIAd3olYU3Yhm8YRRqjJAPqksv7vkCQFMaQ
	NYMoSziETxWyhFjXPMmUPGtdYc2HVzBO0DyoPHomsRpDSiuh44jFQwJlFTywIg1gGTHOj0BAcKI
	cL3kk4pf0zi5y4gTN4aYC6Vark60jnt0MwVqmGGSSjmr+heRYu10Ncx9PTvoq
X-Gm-Gg: ASbGncvJacqGkEIse7DjlEp+ZeQmUJbzRKNbn696p1wQdEi/M27YQTTBVPTI02OHcFQ
	58BeaSY42l6pp0VMujFTZDsx6vp2ntlCBAM6CHfPdwVht7Rz1Or6BWMBO5eYk955EaxN0jgV6eP
	79uxTWx50vHNctrUAEyuy/rfvNzm3GkG7zhrytsLf0hHTs11cwM/2cRpzRPK6uPDNUDVkU4JC9O
	W97tzZ/1AGr4AUJN2en49OmXSGplqFuM4XAn8kNwWaLndIuSWqO6oq2fFv+kEl9rSQpK9zS4VgV
	2qZOWbfG9J0iGjXC8mcQglOj+TjuF1acl1nYbxsTCRj1fZU/NxMUokkRXJtabNrtWI+fzefzOYb
	JXq06y+9YI75IrNgr12jLVOCdD4xvtH5t2e1JNKw=
X-Received: by 2002:a05:6a20:1592:b0:35f:68d:430e with SMTP id adf61e73a8af0-3614eb3a0c4mr11232938637.9.1763982767821;
        Mon, 24 Nov 2025 03:12:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5DBVr7Qie8oxPbSqRQlj+suGHKQHP5xAj9wdWg1PBGhhTWDP+uMNpEZrPc1J19opeuzRjvQ==
X-Received: by 2002:a05:6a20:1592:b0:35f:68d:430e with SMTP id adf61e73a8af0-3614eb3a0c4mr11232878637.9.1763982766546;
        Mon, 24 Nov 2025 03:12:46 -0800 (PST)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd7604de68bsm13133780a12.21.2025.11.24.03.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 03:12:46 -0800 (PST)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Subject: [PATCH 0/2] battery: Add SiLION battery technology
Date: Mon, 24 Nov 2025 16:42:39 +0530
Message-Id: <20251124-add_silion_battery-v1-0-3c86b70d2543@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKc9JGkC/x2MQQqAIBAAvxJ7TkhRwr4SIVtutRAVKlFIf086D
 sxMhkiBKUJXZQh0ceRjLyDrCqYV94UE+8KgGmWkVFqg9y7yVjQ3YkoUHmFGjbbVVhtjoYRnoJn
 vf9oP7/sBcjruwGQAAAA=
X-Change-ID: 20251124-add_silion_battery-5b4a97494559
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kamal.wadhwa@oss.qualcomm.com,
        fenglin.wu@oss.qualcomm.com,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763982763; l=963;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=GXzOHUcu8jmVZSISxvrMjghCvNltj3MFWdbS2tT+y0c=;
 b=zZey+HF7diss5s7qGKahFW6LJr8dmboY4qGMBwt6UL/jJg/IWASFwGSCzIMqYauN0VMAVbx3n
 kMzXkD2xlJSDLycEhWZs2JKYrooBKG0lUwsrlm7XWQVV2rs4b8FftV1
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA5OSBTYWx0ZWRfX/WP26Tcsqbih
 J1bW+QBOIcOs2KXDKKgE1y96A4c/o5sDk1a2P7cWjngEPSRjx4YHVgayXzA06+LunufnpzqtKjz
 x+FPh2Kxyz/gRsXBYLlZ17QXnpR5gQS11ZR2lNpApZn6o1K9llmWjotTQ2eBurxgx0LROaDFgv9
 qmyiHQsZyNMS09XGBYeV1dulpO1VFX4cztdSHrhk5sPRJnDEyG5rMnG3Xcr7kDKgQjVYnp+7oGm
 LR2xuwi/U+zuFZqnSjjPC21j587lZwd+1WxNHH1HiLEQFZW/qG2nAaEeWt5HNRgkgH/xLITkD1Y
 WJirEGgqIZsRElAS+gvCuM2n6OAluTHJQTZd76n3FYkhH9RYFwfqSfj0v8Hoi6eJiKW8cFIeEc6
 msGAifkdZk2+fHyTZ+WuBj8vvKIfmw==
X-Proofpoint-GUID: pLULHBglWevxYyKK-hJyCvXtTD1Rcg1W
X-Proofpoint-ORIG-GUID: pLULHBglWevxYyKK-hJyCvXtTD1Rcg1W
X-Authority-Analysis: v=2.4 cv=GoFPO01C c=1 sm=1 tr=0 ts=69243db0 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Tmu3GerIYFeC-vN7JBYA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240099

This patch series updates the battery dt-bindings and
driver to add support for SiLION battery technology.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
Rakesh Kota (2):
      dt-bindings: battery: Add SiLION battery bindings technology
      power: supply: core: Add SiLION battery technology

 Documentation/ABI/testing/sysfs-class-power                 | 2 +-
 Documentation/devicetree/bindings/power/supply/battery.yaml | 1 +
 drivers/power/supply/power_supply_core.c                    | 2 ++
 drivers/power/supply/power_supply_sysfs.c                   | 1 +
 drivers/power/supply/test_power.c                           | 3 ++-
 include/linux/power_supply.h                                | 1 +
 6 files changed, 8 insertions(+), 2 deletions(-)
---
base-commit: d724c6f85e80a23ed46b7ebc6e38b527c09d64f5
change-id: 20251124-add_silion_battery-5b4a97494559

Best regards,
-- 
Rakesh Kota <rakesh.kota@oss.qualcomm.com>


