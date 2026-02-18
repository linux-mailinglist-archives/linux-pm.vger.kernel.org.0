Return-Path: <linux-pm+bounces-42803-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDYRLoJ0lWnDRgIAu9opvQ
	(envelope-from <linux-pm+bounces-42803-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 09:12:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE35153E40
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 09:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D70543018BE8
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 08:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0DD31770B;
	Wed, 18 Feb 2026 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SoudCh3i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GOitX+81"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612B313547
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771402357; cv=none; b=qxQhUi/34nb4dzraOuypmhmesK4Dzbepb4jw2DGZWeC0FHS25WJ9ew1dsgbmg5V/U2DaC7gcEeDkvdWvnX00rc2Nt0N8Mzx0N8zZg9nYvN5qhqCffG6JurVs4BpsWjwoS09Nb6sd4H94xDtI8i1KQgM2/dwbkK4PPNICRAu5jV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771402357; c=relaxed/simple;
	bh=cn9bRtPL63s+L/kliS2QPtYEnu9wEkOpMMxQLo4/E2w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a+Axe4CqPwdPIlG5Xz/BviwRYI3RRi8+H1Yc6T8J82UcFvy+pLvrOL4qC7GJxeEKgOC0wsbYtfSYQ2VRXNvfB38fcm6xcP6RS4lLxlBm1/9rCI/NMumRDFjIcBSkq57iYITf7BgMFQPLjmQCOo0phseQRundJHaU3alXXuX7nLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SoudCh3i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GOitX+81; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HN878O4060756
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 08:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hKZlV/zjE2Jec2OpeZ2fnA
	tbU0O5jNpjC5Zzj54JMio=; b=SoudCh3imLq2oU6ZjxDWGq5hV9LuNb8hMdba9z
	ojq/3g7mEHZFFRrl7y4UDbtNPY/XiG64lwQ2k9BtGNwW5OYYBkE5QN1otE5j5jZT
	BkRYQsdXmEH4MOvyGcvN62/T5T3HXp4PiqY9bF1nyek6QB4wBNL2Hf/57/G+wmtz
	8yKPlODlzOCYDEU194hbfNTMPAPwpEWB5ISxRLg+4aDuhxBGneql9PnIiPd2xPYx
	flTG5nDtiJ27GB4oe1E5m+ksN+faIlKBEMnTNpVRKP+s7fgKZlBA2kBrO5XMuaG2
	KzvcyLTjUIiRrOgHtXNVqTPgrO+46Cvl6WDrKOWI7nnOIMkA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cd1qx124q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 08:12:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a944e6336eso296733385ad.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 00:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771402354; x=1772007154; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hKZlV/zjE2Jec2OpeZ2fnAtbU0O5jNpjC5Zzj54JMio=;
        b=GOitX+81H93knGYFn+IPnoHSc77dudhUXucU7w2N2mbNtfEr5HkRiSaHlDfwcNOVfV
         ITfEdU2KdruU2k7KTBU/60KqKL5KkWE2G6EtqH4wKR34WyD+a66mgPlZQQygA8y0c426
         evweFfpyN1nigRxh8W+B/azn0plwiZ15+1kS1jshRpDYeCD+ro57mTg3rN95frLz1DvW
         nij/kgT/cr8RfxtOZ3VepBXh7Gh/3j0QPCpF98Ott8/RhnaQF8L1YoCXraJlM0BjNfzn
         hSQ2tPmLRr5UWlbh2aYpUhjifKJu+PEjqphxbw23D4JaH9EQqrrp4IK+pLAMoRV/OtnZ
         CzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771402354; x=1772007154;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKZlV/zjE2Jec2OpeZ2fnAtbU0O5jNpjC5Zzj54JMio=;
        b=f5tJSO/8f81Rjs54nD0Rvl3nYbKkeyxdvSDIguc1wu8HFBkq0xxoi7wlRelAS8KDKp
         X5KA0dwkftJTJJmNNvAawxHCfJ8Qh+KlUQjH/paK2GU11FGCA8ZbN4SXodwnsWEJW0hO
         i2c/edTCKqVsHn3DTXptYIQfOFHO0iyOoJA+4Hj/zhSsLV6DJFs3qcllJINdQPIKdJG5
         q6MyZzGpYRPUHzudS8kU9rfY8xyekmjIfvP7vaqESENmIoecpdU0NO3BNGo/6MH47mOb
         iS719pt/xzeLSNJRf0j3zNp6UjAKtJ/pGfVo95fT57IATFvPNARbCHwpgyC/Ch9FQvTp
         Bh6A==
X-Gm-Message-State: AOJu0Yx/3RSnvsYs9qRxv+zMVVYjMOZvI6MNGRLIXXTxGh9q3TolFjjy
	jUEr2RLnRZDH0eifBsNiSxRSTDXwXACrGnPHmenMdtDS8exmYwmQRulU8X+qg1I/xb3Wdm+WIWY
	Qrs9LFLKZF62nfkP6NIAxOWzHXPbbXVI6quEHHl1tfnxyRxHwzMTq8OJXCzWJSw==
X-Gm-Gg: AZuq6aKJAfZu2zjc3DeHbs8As4KhmY9Hle8+mfJmnEsGLjqILA95zAsAVOme2bK2/HX
	X2BxAI7ZsjOTcBu565TgfwQmD1BhvhZuEZjjbAwC55QLonKH0Jb4sfmPKRYlDkfTMJCCJCLv8sR
	If8tEO+9FaswBHrRKg1aQcFgcNmJGOzdTt+yysDyBLwwVr9BYO1Z9z9LbvNUkXFUJIW2nAZQNMs
	cH7BE/japOTYQy7g163nU85+JW2V9tawqdCw7iVcBC5e1QDFgC9AvmQJbUIXoZAthuEn1rklO0J
	yi7ZAHEDu3J7VKtM+IH2QxWfXwwi74i6svD1TGrBdzXDV1G8dggot4+xQW/n8qQbJbhGpWS+vPi
	wokKbIYN+jRwenVE3VkV6/1QGGZwf8qhuuxEHWXzqfOlxXxDJW3oIfX1G
X-Received: by 2002:a17:903:2b05:b0:2aa:3b3:d633 with SMTP id d9443c01a7336-2ad50ff1164mr12524585ad.61.1771402353738;
        Wed, 18 Feb 2026 00:12:33 -0800 (PST)
X-Received: by 2002:a17:903:2b05:b0:2aa:3b3:d633 with SMTP id d9443c01a7336-2ad50ff1164mr12524395ad.61.1771402353204;
        Wed, 18 Feb 2026 00:12:33 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d624esm118123685ad.49.2026.02.18.00.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 00:12:32 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v7 0/3] PCI: Add support for PCIe WAKE# interrupt
Date: Wed, 18 Feb 2026 13:42:22 +0530
Message-Id: <20260218-wakeirq_support-v7-0-0d4689830207@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGZ0lWkC/23N0QrCIBSA4VcZXudQUbe62ntEhJm2Q21uulkx9
 u65QRC0mwP/gfOdCQXjwQR0yCbkTYQArk1R7DKka9XeDIZrasQIE5QSjp/qbsD35zB2nfMDtoJ
 rflGKllqgdNV5Y+G1isdT6hrC4Px7fRDFsv1axZ8VBSaYS25oYZlmRFcuhLwf1UO7psnTQAsZ5
 Q/DNhiZGEmsKKndc0bEBjPP8wdTuRzb/AAAAA==
X-Change-ID: 20251104-wakeirq_support-f54c4baa18c5
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com,
        driver-core@lists.linux.dev,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771402347; l=3933;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=cn9bRtPL63s+L/kliS2QPtYEnu9wEkOpMMxQLo4/E2w=;
 b=1NrTUTrlOuXkM10nOweTJb+5me+RqaT/bCS5HXsMXfsEdvuIFx663a7YJjaz1VTUelwNaOP1Q
 nggN0JcfMQ3DKk5PZt6fd2/sIATbUJC/GcjnDkQjc++4i37OtQ/mhLg
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 4786UQePKttooheEybCn3KmoqlCPOqpW
X-Authority-Analysis: v=2.4 cv=R7oO2NRX c=1 sm=1 tr=0 ts=69957472 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ikd4Dj_1AAAA:8 a=s8YR1HE3AAAA:8
 a=7FPx-eIICnbx9kjoaAIA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDA3MSBTYWx0ZWRfX+chk/zRb+a7c
 MqzD0K7XTwUDZ8wsvOj0bFNn85K6I+72WXC2EmMqNiBY6MmLoi1geNMUFHFnBt7U4MvWHuif1bM
 JHTJiDJxbALmur6a7r1/gFN/LoE/QAlxReM7W+WC/7NH8vfksdcTP7HUQbbN+UzDD1fthW9kS6N
 QM+FDFY0S2hN0CYr6DEujtGrGtVTPUTgD8o5Okdi4QHfZqZNb0LIt1rLgsbS5HEX7kjYRHve1Mr
 tsKXxnhyTPAGJGMrkPQvxGGZT4L/fpQ4GWxNlTvMT+vQOWY2sWT1hXzMTlzJ0/2nKnLu9wcryus
 olAgzsjRWRghvZYer5bqkEM1NuWWX9tWIXpSnbgVDmR3P/IL41cg+iDNGJF4OfEt4NGJWnBgZxM
 HY8WigAp1B0RFaS6Pf0GA+yMoFnXytpueA4kTwc+UWcMmoljYhLYufWo4Ib6DepWemNaF9V+h+u
 ZhzvnoWAaYpR8U2YSgQ==
X-Proofpoint-ORIG-GUID: 4786UQePKttooheEybCn3KmoqlCPOqpW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180071
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42803-lists,linux-pm=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Queue-Id: EFE35153E40
X-Rspamd-Action: no action

PCIe WAKE# interrupt is needed for bringing back PCIe device state from
D3cold to D0.

This is pending from long time, there was two attempts done previously to
add WAKE# support[1], [2]. Those series tried to add support for legacy
interrupts along with WAKE#. Legacy interrupts are already available in
the latest kernel and we can ignore them. For the wake IRQ the series is
trying to use interrupts property define in the device tree.

This series is using gpio property instead of interrupts, from
gpio desc driver will allocate the dedicate IRQ.

WAKE# is added in dts schema and merged based on this patch.
https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/

[1]: https://lore.kernel.org/all/b2b91240-95fe-145d-502c-d52225497a34@nvidia.com/T/
[2]: https://lore.kernel.org/all/20171226023646.17722-1-jeffy.chen@rock-chips.com/

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v7:
- Updated the commit text (Mani).
- Couple of nits like using pci_err instead of dev_err,
  use platform_pci_configure_wake(), platform_pci_remove_wake() instead
  of calling directly calling pci_configure_of_wake_gpio() & pci_remove_of_wake_gpio() etc (Mani).
- Add a new fwnode_gpiod_get() API that wraps fwnode_gpiod_get_index(..0..), similar to
  devm_fwnode_gpiod_get() (Mani).
- Link to v6: https://lore.kernel.org/r/20251127-wakeirq_support-v6-0-60f581f94205@oss.qualcomm.com

Changes in v6:
- Change the name to dev_pm_set_dedicated_shared_wake_irq() and make the
  changes pointed by (Rafael). 
- Link to v5: https://lore.kernel.org/r/20251107-wakeirq_support-v5-0-464e17f2c20c@oss.qualcomm.com

Changes in v5:
- Enable WAKE# irq only when there is wake -gpios defined in its device
  tree node (Bjorn).
- For legacy bindings for direct atach check in root port if we haven't
  find the wake in the endpoint node.
- Instead of hooking wake in driver bound case, do it in the framework
  irrespective of the driver state (Bjorn).
- Link to v4: https://lore.kernel.org/r/20250801-wake_irq_support-v4-0-6b6639013a1a@oss.qualcomm.com

Changes in v4:
- Move wake from portdrv to core framework to endpoint (Bjorn).
- Added support for multiple WAKE# case (Bjorn). But traverse from
  endpoint upstream port to root port till you get WAKE#. And use
  IRQF_SHARED flag for requesting interrupts.
- Link to v3: https://lore.kernel.org/r/20250605-wake_irq_support-v3-0-7ba56dc909a5@oss.qualcomm.com

Changes in v3:
- Update the commit messages, function names etc as suggested by Mani.
- return wake_irq if returns error (Neil).
- Link to v2: https://lore.kernel.org/r/20250419-wake_irq_support-v2-0-06baed9a87a1@oss.qualcomm.com

Changes in v2:
- Move the wake irq teardown after pcie_port_device_remove
  and move of_pci_setup_wake_irq before pcie_link_rcec (Lukas)
- teardown wake irq in shutdown also.
- Link to v1: https://lore.kernel.org/r/20250401-wake_irq_support-v1-0-d2e22f4a0efd@oss.qualcomm.com

---
Krishna Chaitanya Chundru (3):
      PM: sleep: wakeirq: Add support for dedicated shared wake IRQ setup
      gpio: Add fwnode_gpiod_get() helper
      PCI: Add support for PCIe WAKE# interrupt

 drivers/base/power/wakeirq.c  | 39 ++++++++++++++++++++++++++----
 drivers/pci/of.c              | 55 +++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c             |  9 +++++++
 drivers/pci/pci.h             |  8 +++++++
 drivers/pci/probe.c           |  2 ++
 drivers/pci/remove.c          |  1 +
 include/linux/gpio/consumer.h |  9 +++++++
 include/linux/pci.h           |  2 ++
 include/linux/pm_wakeirq.h    |  6 +++++
 9 files changed, 126 insertions(+), 5 deletions(-)
---
base-commit: cee73b1e840c154f64ace682cb477c1ae2e29cc4
change-id: 20251104-wakeirq_support-f54c4baa18c5

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


