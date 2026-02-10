Return-Path: <linux-pm+bounces-42413-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBowI/L2imkePAAAu9opvQ
	(envelope-from <linux-pm+bounces-42413-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:14:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D34F4118B98
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EAAA3029AEB
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 09:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC3B335547;
	Tue, 10 Feb 2026 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W1ls57pX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Huyfihg/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965AF33CE9D
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770714859; cv=none; b=rkVq8nCm22BBUyMQ9feF5nbVvjVRbVELNqCrnqTQXJkF5GRSogaCUGuFaVeW1Hg61AJIYDJ8SHTifo+FpceDAVy3tbYp/JBY2Ma3DXyA3D4NGaGzUt/4rYNM9rg/bkRADRh01IwwttgQrKQp/sM59EUhGvIuXanwblba7nbFqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770714859; c=relaxed/simple;
	bh=vi9EVrWEQjBwehzjUvNaI+VOOZW9+/2nbX9SJhHs+H8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hCDxIJy7KUOWm/zFcrxuOylwUQ+MbwcByotLbqCaW0G3KY5TXdzDeotViilBx7z/iaGerCOJukVHc7F/rPCjcmy3SoRp4tu2hF6rdjsbHTRRY/BqC9jc1vN2ss0/kYMuYHQMk+0Klq1pZHqaImKv4euxF0pGc3QVUZmzqf+GVTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W1ls57pX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Huyfihg/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A7705H1151743
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=V0LHFUrSxEKNl1fCDeVASC1nXWmst1l3Toc
	VZHIMdGg=; b=W1ls57pXz1y87v8eTvQ6UoSnuQJv2Y+KA9/WkmToKz920wgikY9
	/wpGXZP2yGu9pXfyMHd0arBvPAX0jjzY4zpnhLt/7cps4tFA6+DprBILuVYt6oMf
	I/e8BXAzWeLRguohEMgPAR9Su59plwGjj9kYLqfqxueDgXgc1j6JWbW5fWskMqN+
	/p6Fyz1c211oBGmToIYmOOTxunfFyHq8ecjP6CB7kS6axOXV7DQYk1KoESoTH0tq
	AEC3GLbvouhkmMFSJyTg7SebxW44XLDIvffbYr0hThmBdCEjILWESUbG4MbZs7DZ
	5WOLw1oTgY6qLi6SHwOlr+rlKs4qEWr6i9A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c800j8evt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:14:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c5e166fb75so1638734485a.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 01:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770714857; x=1771319657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V0LHFUrSxEKNl1fCDeVASC1nXWmst1l3TocVZHIMdGg=;
        b=Huyfihg/lchQta4UEFvSjZIl7Cb1O3r3GRKL1CRoXSbsRvuVTBJcwffPrD8ku1CTV4
         nHL3yX/wvif9TSwQO/KhXCpAyatOFfKqjwLIQZJfDiruGA5rchzJPHNo0Fqgm2AZ8LFU
         xlBL87DU1sMP0/TrXyDFshYBOE+3qY2GsVxxIzRzzhLEdBN7BD6e6y0EcCSX9zUdntoA
         dAhN8NG5L4tSpwT5v/kkPmgt7px3T6135opsUgcKB6O5HYL4jMALLqy4FrWW4bKvlrYL
         TICiXBBF9bORtvNtX2XbWbtNhAr9M2gfn3X8STkouWWp2TZ6xVK15tjNibyzbI3I4Lik
         pNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770714857; x=1771319657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0LHFUrSxEKNl1fCDeVASC1nXWmst1l3TocVZHIMdGg=;
        b=LcUkhoyO/3rGY8RRG5S3U/blKjtUVozjE2bu2peAWfhRyX8tLr40YjMrR5L7771owW
         iLpjrK6zmbOZ4vgo4kBF7aFY+mKWgAN7JpwNkDuIYz2Ycw1rHq+n4flcFTCzcVjEFjm6
         btDikbeMw4ynGEY5HfKUr7EYWHL5mi5RsMIV6PbRJDQu3ghCtLwoMJB3M+bRp6aFHffc
         Too/RveMEWWstjkJH+XZuED8Eaa7LlcWm4l3aVqYvVa2zdcL0tTGvSYrmUQ9DVa4o5vN
         8jy/ARFu7m1SNgfKdjguyE7KlsZ654gSNH3IRaNm4qgfJ9lilS0vEytd0pCaL8fu7wse
         67dw==
X-Gm-Message-State: AOJu0YytcFOFyL//vb5a7PXPNcf8Zl6FzKBNApN0T2BLlWGxaiLyjzFk
	jrJNPnFDDHxmagV7b2oqW2C3Ibftbp1aJDrg2y4IswUoNlNckMKMhNKDvxSeYhft11C4cZ+Kzc1
	rJnGI7maDeEpvUuJafeMkzajziiFmD58Gx6hp0CkRSlHEyI7hJnA9DUH1sHKmaQ==
X-Gm-Gg: AZuq6aJQ3BMMmvZI9DiXWn10jmuRLx6lJX91wRU21anH8g3t3D1LGXPat7c2889bQmk
	7urTnFQKAF5/10m5IXl4zBSX0ZKC38S7yT+H6icda0e5uy5HemMVEGZrVthXZEcf44mOsfbJ7+p
	nfoyOo+PRHS/bjs59ekVk1O5KXK7l1L2qNriiY50AbZcbi6185FFJPbIcL/5XKd4KRW0lX2Xa8+
	qTMRcwxdPd+BuOFsENBymbPA72pCQY+onvitiVXmCsJ8QCsqibzFqcFQ0MPCMr2MQnGdc7GQRNV
	bMqObtNt75kvvkhOwHXs9QQguYcRXh2P2bZuVyq/MAK1NLcrmHahFmV4wGOeT+jGcbENxdBySGz
	SyPj4WxzMxyxNz6DrmxfFUXufqq6BNNS3dxZc+f477aT4SgxwkrI=
X-Received: by 2002:a05:620a:7103:b0:8b1:be0f:da52 with SMTP id af79cd13be357-8cb1f6b208cmr166194185a.7.1770714856806;
        Tue, 10 Feb 2026 01:14:16 -0800 (PST)
X-Received: by 2002:a05:620a:7103:b0:8b1:be0f:da52 with SMTP id af79cd13be357-8cb1f6b208cmr166191485a.7.1770714856368;
        Tue, 10 Feb 2026 01:14:16 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:1964:f977:ccfd:e173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483209eeef0sm107399225e9.20.2026.02.10.01.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 01:14:15 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [GIT PULL] power sequencing updates for v7.0-rc1
Date: Tue, 10 Feb 2026 10:14:01 +0100
Message-ID: <20260210091401.24342-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA3NiBTYWx0ZWRfX7X2ysU4LrDJh
 tTsOSILN3LSFFUyH+JjxKRe3j8MKx5evW8T2n8jsvsbcmU82KDklOeu0iP895i6OZJJZOXwb71/
 drs31BBJ46PsxdhXZdqwbogFhKzA8d+dU/qUOEiolmyv1sT4qZ4Xe5xESuXolr/l6z34A/QH04Q
 wyuGyuZ7e7K7hHzdshuHSypu2Y+GSmp1cNxCWtdFfN1tA0JpGEj8FaRqqP/tmjOZGH8+1AuOWyB
 7yGy6hI0V52KYB29kKlAgDC9UW4zmsv6e6Qer5VS/DwoeS91RB/mUnhIwlywzKHaPBkFxBfhynh
 CUwydLgSv/ORk/oDVwy+xH/mAKwyxLiQupvAeAkq3DvxWygDlYoIjOyhDAkTLRmTAXOwmKUzvDg
 QGIcydgAuDftGCYFVh60TtQEvO1mO/fAamSANV+bB30gW1f0Pp7OCGbZMFX8R7qVIysWwZkvkWy
 6F3UKAhNos6gjOLBqKw==
X-Proofpoint-GUID: LY5NfGXJ3Y99cStwr-zl5PYGSELPbnPB
X-Proofpoint-ORIG-GUID: LY5NfGXJ3Y99cStwr-zl5PYGSELPbnPB
X-Authority-Analysis: v=2.4 cv=b9u/I9Gx c=1 sm=1 tr=0 ts=698af6e9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=33PpWzlZdlaQRvv78ZcA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100076
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42413-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D34F4118B98
X-Rspamd-Action: no action

Linus,

Please pull the following set of updates for the power sequencing
subsystem for the v7.0 cycle. There's one new driver and support for more
models added to the existing qcom-wcn driver as well as some minor tweaks
and fixes.

Details are in the signed tag.

Thanks,
Bartosz

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v7.0-rc1

for you to fetch changes up to ecfcae7885f105b29898ff71d3cb70abd56ef96e:

  power: sequencing: qcom-wcn: fix error path for VDDIO handling (2026-02-09 10:32:27 +0100)

----------------------------------------------------------------
power sequencing updates for v7.0-rc1

New drivers:
- add the power sequencing driver for PCIe M.2 connectors

Driver improvements:
- use device_get_match_data() where applicable
- add support for the WCN39xx family of models to pwrseq-qcom-wcn

Fixes:
- fix a locking issue in pwrseq core
- fix retval check in pwrseq-qcom-wcn

----------------------------------------------------------------
Bartosz Golaszewski (1):
      power: sequencing: qcom-wcn: use device_get_match_data()

Dmitry Baryshkov (3):
      regulator: dt-bindings: qcom,wcn3990-pmu: describe PMUs on WCN39xx
      power: sequencing: qcom-wcn: add support for WCN39xx
      power: sequencing: qcom-wcn: fix error path for VDDIO handling

Manivannan Sadhasivam (2):
      dt-bindings: connector: Add PCIe M.2 Mechanical Key M connector
      power: sequencing: Add the Power Sequencing driver for the PCIe M.2 connectors

Ziyi Guo (1):
      power: sequencing: fix missing state_lock in pwrseq_power_on() error path

 .../bindings/connector/pcie-m2-m-connector.yaml    | 145 ++++++++++++++++++
 .../bindings/regulator/qcom,wcn3990-pmu.yaml       | 100 ++++++++++++
 MAINTAINERS                                        |   7 +
 drivers/power/sequencing/Kconfig                   |   8 +
 drivers/power/sequencing/Makefile                  |   1 +
 drivers/power/sequencing/core.c                    |   6 +-
 drivers/power/sequencing/pwrseq-pcie-m2.c          | 168 +++++++++++++++++++++
 drivers/power/sequencing/pwrseq-qcom-wcn.c         | 133 +++++++++++++++-
 8 files changed, 560 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml
 create mode 100644 drivers/power/sequencing/pwrseq-pcie-m2.c

