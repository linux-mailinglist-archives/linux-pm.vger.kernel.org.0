Return-Path: <linux-pm+bounces-23018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73205A46933
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 19:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE3207A9144
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 18:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8013B234970;
	Wed, 26 Feb 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VmATNXiN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEC7238140;
	Wed, 26 Feb 2025 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593443; cv=none; b=gcpcqNSXKu15tRQB28sZi5RL6N/5u8tkZK2aDueP0AA4mCfDMcDeczH0b1RjlQuxMKwUa5QnCnNOn5fSNpOnLnHPOXLOOugA7n6ePBAVF4kM6JMBGN7fZ0Cp6YsG03DA8XH+LQYl56fD8BzWJKEyqa5eBqtsCI5vi23mjmfnepw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593443; c=relaxed/simple;
	bh=g+WVmMBcEHw/mh2I08E4bmd/znjw3ZUG1VmTY9195Z4=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=IH2MCmkyRkg+pKyOVKc4MJ19zM4Geeg2MXbyKb+q3laJWuPGR0sAsnpV+9cprhEFNbc/6uu83ZFdmlOwkEOG+e1ereymXuUAfyqchJVPZrQc1hO/q+KpPzq/P0decDSUH/KCPrWv1D+xueYJzmfxm0xZH16ysfYlKludohq8VDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VmATNXiN; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1740593287;
	bh=g+WVmMBcEHw/mh2I08E4bmd/znjw3ZUG1VmTY9195Z4=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=VmATNXiNpiNhP4xPczWrA2bbotj26WW5LrxQDpwXoIvpYqnHKHZ96fh40kK53ifu/
	 hGG4ckmN8bE5DRTvTuskXL+ac6Sdw5D+gpVVGHUi6GiF2qdwcfyacVRcEFM36Ix8vd
	 d7hZE/27Er6/e4QJ/TwWpit5yfQREw5tE87s7068=
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqT6iyfUez+DXx4B7ybItHVbSxkDlA8/kMI=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: JtCBZ5ymfZPhsUinjHaER1gHqeRkrPE8F3mOU8aVB4k=
X-QQ-STYLE: 
X-QQ-mid: v3sz3a-6t1740593277t9517932
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?UmFmYWVsIEouIFd5c29ja2k=?=" <rafael@kernel.org>, "=?utf-8?B?546L5pix5Yqb?=" <wangyuli@uniontech.com>
Cc: "=?utf-8?B?cmFmYWVs?=" <rafael@kernel.org>, "=?utf-8?B?cGF2ZWw=?=" <pavel@kernel.org>, "=?utf-8?B?dGdseA==?=" <tglx@linutronix.de>, "=?utf-8?B?bWluZ28=?=" <mingo@redhat.com>, "=?utf-8?B?YnA=?=" <bp@alien8.de>, "=?utf-8?B?ZGF2ZS5oYW5zZW4=?=" <dave.hansen@linux.intel.com>, "=?utf-8?B?eDg2?=" <x86@kernel.org>, "=?utf-8?B?aHBh?=" <hpa@zytor.com>, "=?utf-8?B?bGludXgtcG0=?=" <linux-pm@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?5Y2g5L+K?=" <zhanjun@uniontech.com>, "=?utf-8?B?6IGC6K+a?=" <niecheng1@uniontech.com>, "=?utf-8?B?6ZmI6bqf6L2p?=" <chenlinxuan@uniontech.com>, "=?utf-8?B?SHVhY2FpIENoZW4=?=" <chenhuacai@loongson.cn>
Subject: Re: [RFC PATCH] x86 / hibernate: Eliminate the redundant smp_ops.play_dead assignment
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 27 Feb 2025 02:07:57 +0800
X-Priority: 3
Message-ID: <tencent_18C611757FED8D54331785FA@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <CF154B5C3C8E7E64+20250224074357.673094-1-wangyuli@uniontech.com>
	<CAJZ5v0iigAB97mGBe6Uvr0v0spjqDKan-0O9XGObt5b4ZBvM7A@mail.gmail.com>
In-Reply-To: <CAJZ5v0iigAB97mGBe6Uvr0v0spjqDKan-0O9XGObt5b4ZBvM7A@mail.gmail.com>
X-QQ-ReplyHash: 2641130897
X-BIZMAIL-ID: 13043415646377140702
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 27 Feb 2025 02:07:59 +0800 (CST)
Feedback-ID: v:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ND42uzdxTIzr7xhYHUIuHOBk7OylMVzd/MFSzGNRiJb15RMVkvfbjDk8
	LqcJl/Wi+gyLfBiJXxs9fUX+exPNm3e26gzrSD1OrIJMayaNPts6CBTCgJbjqnRUlxrQfxb
	x9zAyqC54fdxY8clW6mRURC2cpelmbrM1poArjc/7nI/x70WHsqcfA9RPOmhg/F0KepBkk+
	JmHxxz+ppqOIqQU4rNPz+1iwhwrw1hDdeQrUmZefiL703Vb83VjpdZvDOhmckcFDb/bs/4f
	fU4iYKg5q8YkR1j5EAW5ug6h5TJ1F0X0ViqZuD2OrC49t/Q1B5R1OCm3SGkJ/e2jRjR/v1H
	pKIefUiP4g56hfnGx4m0+e4XPHwoEhqPp/zhXLDBZs2CjHEijZczaQxElTBp98k42C1bDUu
	4OpeGiOZfRpyzLVTnfmni7M8sVnbh0yTlShEuZIc0bXCj45o07ohzoSlDVUz7wZ/UZJf57J
	F25NhIqLD3diqREeQjG54msi5roeDDYpJEzHc7JXjAnaHQYluECF/ODWAp2yxx1m10uZwa2
	Vd3aDJ4+H7WfvHvEsLKQ4xGDdaUIEvubXIqJQTFUXidY6/Xz6Jbgyg5kXCYAqRgx2PlWJCz
	kGBG4pv6oVb9tNl5aFe7BHLG73mSCPbpc57U9CSBEe7U3P/jchpVI3Ot8+6/aO5pv6F8JyF
	4fv0RuRYwB73OYw1K7UMnqmI8sWiNh/Lp4T8Qf8S+il37GEYy/au9ZU7VKB6E2MmRoyF9DN
	v+OK41byxajpqqO0QzVAO8q99C19UD3f4+Wxu6SvTHKiNVIZ36YgLNIoqYVFVPcaB1Lw0tD
	V+Q5m8tJMcnyLkDh0gKyyEwGZigzDwUpneIbY7oIUDntv36ociFEqtEKedvzh6rWbnMGUq7
	8AWxZ2gmZy8xzLWwXNqTw3pJasdYF6vKjr/gNCITvAYrlt6BRdpzfCEf8zPUJ1TtvPxvj/y
	8FLlgyjXfJDbKI0woj6m9aQWH4mVQnkqm62Fv/kYURJPDnbYrGd+XJnmjgfF+L8ZhfokVyk
	z+dS+mw33OBn/hUPye
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

SGVsbG8sDQoNClRoYW5rcyBmb3IgeW91ciByZXBseS4NCg0KSW4gbXkgb3BpbmlvbiwgdGhl
IG9ubHkgbG9naWMgZGlmZmVyZW50IGJlZm9yZSB0aGUgcGF0Y2ggaXMgZGVsZXRlIHNtcF9v
cHMucGxheV9kZWFkDQpzYXZlIGFuZCByZXN0b3JlLCBhcyB0aGUgY29tbWVudCAidGhlIHJl
c3VtZWQga2VybmVsIHdpbGwgZGVjaWRlIGl0c2VsZiIgYW5kIHNhbWUgDQpsb2dpYyBhcyB3
aGljaCBpbiBhcmNoL2FybTY0L2tlcm5lbC9oaWJlcm5hdGUuYywgdGhlIG9rIHBhdGggd2ls
bCB3b3JrIGFzIGV4cGVjdC4NCg0KV2hlbiBkaXNjdXNzaW5nIHRoZSBlcnJvciBwYXRoIGFu
ZCByZXQgdmFsdWUgdGhhdCB3ZSBub3QgcmVzdG9yZSBwbGF5X2RlYWQsDQpJIHdpbGwgdHJ5
IHRvIGFuYWx5emUgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiBuYXRpdmVfcGxheV9kZWFkIGFu
ZCByZXN1bWVfcGxheV9kZWFkLA0KYW5kIHNldl9lc19wbGF5X2RlYWQgW3RoZSBhbGwgcG9z
c2lhYmxlIHRocmVlIHZhbHVlXSwgYW5kIEkgc2VlIHNvbWUgbXdhaXQgYW5kIGhsdA0Kd2F5
IGRpZmZlcmVuY2UuW21heWJlIGl0IGhhcHBlbnMgYXMgZGlzYWJsZSB0aGUgY3B1IGZhaWxl
ZCBhbmQgZ29lcyB0byBFbmFibGVfY3B1cw0KcGF0aCBpbiBmdW5jOnJlc3VtZV90YXJnZXRf
a2VybmVsIGluIGhpYmVybmF0ZS5jPyBdIElzIHRoYXQgaXQgZGVzZ2luIHRvIGRvIGFuZCB3
ZSBjYW4NCm1vdmUgaXQgdG8gYSBjb21tb24gcGxhY2UgaW4gaGliZXJuYXRlLmMgYW5kIGxl
ZnQgc29tZSBjb21tZW50cyA/IA0KDQpCUnMNCldlbnRhbyBHdWFu


