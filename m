Return-Path: <linux-pm+bounces-24902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F255BA7EF73
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 22:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413EB3AC417
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 20:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F0E221DAE;
	Mon,  7 Apr 2025 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="T9o4bMpH"
X-Original-To: linux-pm@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98DF21B9F8
	for <linux-pm@vger.kernel.org>; Mon,  7 Apr 2025 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744059198; cv=none; b=Qh+NoRrTwB29BI88eHThXtKqnkWF6S7VuJKvQNgF+x+hmGluObMw2c5sZxZkr6y4eBu4JRVCXciN7aqv6dAwsslTK0vd27tuRF0HbBw4nuC+hrGnYlMwLY5NS6sfEWX7WbwgRxYeQSvL0IomLVK3bpxkXGbY4LFaDHTLJ16RnhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744059198; c=relaxed/simple;
	bh=7jtTWsuiulJpTBRatoWgFwQ+d2NGShaswDzm5F3oCJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZ+O32+kgym2jMp5zobRTydUQ6E4YSIaQW9HiRMVsv7bOsnLoEZkdGM3W2HmG1Dfu1CRc/yqAD/HZjJNthxNZePAh156/INB0sfnDdTmmfWbhDQoj698t5pS04WtkVYl8hb1evkUPCr9LYLshl9CB0lbRro5Dyz2q5ddyAEk5d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=T9o4bMpH; arc=none smtp.client-ip=195.121.94.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
X-KPN-MessageId: 38e81733-13f2-11f0-8ec8-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 38e81733-13f2-11f0-8ec8-005056994fde;
	Mon, 07 Apr 2025 22:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=mime-version:message-id:date:subject:to:from;
	bh=Rpqa5UZhzB9K0sex41+sa1TheR+P2WBlqqLVmrp8kMY=;
	b=T9o4bMpHIlDTnUMPzYm1ZvldtBYCiI6MBMr34rX/xtYdcXXIMy1r58m3SJDXQaYAA1u8UIHDUNIHJ
	 FvLUJdYNwEiCVAEOPHXPjLL0KorF3DRp0/VL4VSlxbhT+vXlQGSt07HawQlAjhrX+A9wZXNxBT46eI
	 6CXFcatE91ErbeTg=
X-KPN-MID: 33|Qubp1fjT+6IQa1fXc5TkUK+3VAHnAN5j8gjfSVNZC64WOx6FmVKjZN4X8dh2KsL
 mQNg5aFgyessOsM2iAhrlGuw2Hyu/W/d3jk5oq5dWmf8=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|CJneqQswbrBlNpdfPKzP/6kAdxLVCr30QTGPij9I1ZcjNDT9QVskXLZUNRU2Pll
 URoIfFc8crVqmR84aa4SD6w==
Received: from localhost.localdomain (77-171-66-179.fixed.kpn.net [77.171.66.179])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 29be2b94-13f2-11f0-97d1-00505699d6e5;
	Mon, 07 Apr 2025 22:52:05 +0200 (CEST)
From: Jelle van der Waa <jvanderw@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-pm@vger.kernel.org,
	Jelle van der Waa <jvanderwaa@redhat.com>
Subject: [PATCH 0/1] support charge_types in the extensions API
Date: Mon,  7 Apr 2025 22:18:44 +0200
Message-ID: <20250407201845.332348-1-jvanderw@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jelle van der Waa <jvanderwaa@redhat.com>

The goal of this patch is to make it possible for the ideapad-laptop
driver to move from its custom conservation_mode sysfs attribute to the
standardised charge_types sysfs attribute with a power_supply extension.
Along with other laptop models which support an end charge threshold
which limits it to a fixed value such as some Toshiba and LG models.

User space, in this case UPower would then be detect 'Long Life' as
charge_types option and set it.

This patch should also allow the "dell-laptop" driver to move over to
the extensions API.

Jelle van der Waa (1):
  power: supply: support charge_types in extensions

 drivers/power/supply/power_supply_sysfs.c | 23 ++++++++++++++++++++++-
 drivers/power/supply/test_power.c         | 20 ++++++++++++++++++--
 include/linux/power_supply.h              |  1 +
 3 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.49.0


