Return-Path: <linux-pm+bounces-31301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A2DB0E547
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 23:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CD4A657C8
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 21:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB3285CA8;
	Tue, 22 Jul 2025 21:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmZdmW5W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4759285C9B;
	Tue, 22 Jul 2025 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753218879; cv=none; b=GIAMAuUtOKZm+ks7jxXPmj5LbL5rDhkZqBHveqm95n3C/nU3uP2Iwl/02iBfV3VXNV0RQeYW6qS7ilZZFfy7qVJN4qB6o9mMViz27t7/BcQvjvt3PGpF52MepQhul75yLI3ERDjGvOHGmjqBzXgqxMr6wAvWA3BB4USl93G3lfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753218879; c=relaxed/simple;
	bh=HGUIucR5t5JQvms2cHXkmLuVFaDyqstMTCKJVqdWDpQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R1N9mbwvUcQNGIO5JzUkNs2q3tkN0JG8uLw5cJ+8tRWIli7srThpTUMJ/rb6MaLIxwJF5E0QViqFWNDJL/pf8an11nm0uoH02r1w9/9TPsImR15rzOJsEOxbIau8fvxpT9HtNw+N6pVBIAOifmxNhdP9EyzEFU8ZmVxS/bMOGfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmZdmW5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450A5C4CEEB;
	Tue, 22 Jul 2025 21:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753218877;
	bh=HGUIucR5t5JQvms2cHXkmLuVFaDyqstMTCKJVqdWDpQ=;
	h=From:Subject:Date:To:Cc:From;
	b=nmZdmW5WmahGkQt3j2B1sR2g6tGq0E6vvDk9pRM/Q+cp7UZax7i0mUCxIJ48X2HaU
	 NQ553tHD5cDIvrcNkL36AROahnrUWcTpDCRBqBMZnu3t8/1vqp6iLjRznhfJTrzdQ5
	 6R2FAqug3P7Cbxl2qtHNIjlulGM8eRjirr1gT9GGz3CB172T15+xhKbjybzJ+g6yBi
	 7X/hk6IeR7qpZrm0ZV8ZCbGoMOsKAPFfEeigjNjpvk8eYWL3jzI8FbL0JLN69xFAPY
	 PMnHbnyyxKHqlTbzZvtBgLMX2e6Mc2VFda4kOUTjR9aXJ4XvpCvP11XTJlisXGJ7en
	 HVZeEoMluaoZg==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH 0/2] Add initial interconnect (icc_path) Rust abstractions
Date: Tue, 22 Jul 2025 23:14:24 +0200
Message-Id: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADD/f2gC/x3MMQqAMAxA0atIZgM2UgSvIiKaRs2ipRERine3O
 L7h/wwmScWgrzIkudX0PApcXQHv87EJaigGasg3HRFeZ1RGZZ6S4RoWdq1n380CJYlJVn3+3TC
 +7wdporgnXgAAAA==
X-Change-ID: 20250722-topic-icc_rs-fdbc135c57ae
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753218871; l=1193;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=HGUIucR5t5JQvms2cHXkmLuVFaDyqstMTCKJVqdWDpQ=;
 b=OS7NeT9D5IF2GW3lZPgFH09givZNER6ON3Rfe/YUqsmbunIigLKmi41odgQOn18UgIqDrNW9z
 DrewSbeOBcoAsgH4bR1aYLPtpqRJSolNePjDejeweHUrxytQAqtAAVg
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

icc_path is in essence very similar to `struct clk`, so the newly
propsed bindings are understandably based on the corresponding
common_clk module.
This is the interconnect consumer part, with the corresponding ICC
provider changes coming in some near future.

I attached a sample driver making use of these, to ease any testing
or CI work (as the title says, please don't merge it though).

First contribution to kernel-rs, open to any and all suggestions.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Konrad Dybcio (2):
      rust: Add initial interconnect framework abstractions
      [DNM] interconnect: Add a test Rust consumer driver

 MAINTAINERS                     |   1 +
 drivers/interconnect/Makefile   |   1 +
 drivers/interconnect/test.rs    |  47 +++++++++
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/icc.rs              | 225 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 6 files changed, 277 insertions(+)
---
base-commit: 05adbee3ad528100ab0285c15c91100e19e10138
change-id: 20250722-topic-icc_rs-fdbc135c57ae

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


