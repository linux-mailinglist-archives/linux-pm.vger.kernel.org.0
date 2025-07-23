Return-Path: <linux-pm+bounces-31340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CCFB0F3BB
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 15:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721CD1891979
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 13:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1137D2E8884;
	Wed, 23 Jul 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="TR1vvldA"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6262E62BF;
	Wed, 23 Jul 2025 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276256; cv=pass; b=PFjeWGzH4lc6wRzNYCVWMt2ChaU9rj0ullxZrtrWBh5ewYViBKOPvIGdhGLD0JkmlbWDdD+HEGrkezQ1n1C+XGwEI/5e5l6Uk6NioKaGLwL1iUCRYdb7hsRryoEpBKlxjeQQX8OXXgw6WxOAXu1+bqRvl7t4Ei4ZzZV6/5hnZjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276256; c=relaxed/simple;
	bh=0U1Q/u+P1mj4MA8GrUnzY4NHmbwMmWBD7ByV0TXrpH4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OvhrpdmBwW6mTu1X3zTj44izH4dcohbSV0EKYai5A3KrNohM8FDJKWF404pnKQbQyToU+FAc8GYxGIYxxiZ8nLmlKanUKHiUNVRCB7hKPCXOvaZC5ecLMdoBQ0uZdBOqoFWnXxfhuP7ooVSBiePvpHUQA8hEIYq4HImeXTNmo5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=TR1vvldA; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753276232; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lNBNyl5wYWooYKkbrhOixWegEBifPHVw8i7gwW1VGMakE+CMaIS9Nnm62orWFx8h5MKJTm3LvTcwwsHKHuuEvxrNXETsPjywWOH/6S4clm7b9lHaW3pNL4UoXGTT+CGdfvfdDOFaOHSV3AvJqEnkcEDUuTKBkGnDRqLnNWsFcuo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753276232; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TMczoe+e+KJzKyIyNO1Op+f8ixd6FDizNqpLQ3VCsIc=; 
	b=MX7TTGpVP4tg1kO3GM0Q5xD230GAmjm50idk5oVynneCYrw8Nd7KRQiDQY27uKBUlL9D1SwTO+JV+jO9d8hY720xsefpBQk6k1LQ5oSjlPgGSPsBDWfXjzfIj0FwRy8gRBD4cygS/k9o8wPRkWN5+FwdfXOuqefKotr88HnxvQA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753276232;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=TMczoe+e+KJzKyIyNO1Op+f8ixd6FDizNqpLQ3VCsIc=;
	b=TR1vvldAo+Nm9WopdMLG3p/b7vpsEnoEXXE0hUyAkjJddEeNhDFkM1m214/8GFnN
	Oz9h7QNg9uEZaoocY8fUCKPQiD6OYVk/l+b1F7WirNAz7edbMzQn2VzSh9doFcOY918
	84LxDOtvi+o0EbJNqpe0V6BXh98JpyQ3lMqdoKrI=
Received: by mx.zohomail.com with SMTPS id 1753276229366928.9630389473049;
	Wed, 23 Jul 2025 06:10:29 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH DNM 2/2] interconnect: Add a test Rust consumer driver
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250722-topic-icc_rs-v1-2-9da731c14603@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 10:10:13 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Georgi Djakov <djakov@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pm@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D4552EF5-21DB-44AF-8E45-F57B0B8CB853@collabora.com>
References: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
 <20250722-topic-icc_rs-v1-2-9da731c14603@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Konrad, commenting in case this driver goes forward.

> On 22 Jul 2025, at 18:14, Konrad Dybcio <konradybcio@kernel.org> =
wrote:
>=20
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>=20
> Do not merge, this is for illustration / CI purposes only.
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> drivers/interconnect/Makefile |  1 +
> drivers/interconnect/test.rs  | 47 =
+++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 48 insertions(+)
>=20
> diff --git a/drivers/interconnect/Makefile =
b/drivers/interconnect/Makefile
> index =
b0a9a6753b9dc30083781163ccc01dafcfcd0485..913b92080cc0b79846b74c239e14959b=
45b5450c 100644
> --- a/drivers/interconnect/Makefile
> +++ b/drivers/interconnect/Makefile
> @@ -2,6 +2,7 @@
>=20
> CFLAGS_core.o :=3D -I$(src)
> icc-core-objs :=3D core.o bulk.o debugfs-client.o
> +icc-core-$(CONFIG_RUST) +=3D test.o
>=20
> obj-$(CONFIG_INTERCONNECT) +=3D icc-core.o
> obj-$(CONFIG_INTERCONNECT_IMX) +=3D imx/
> diff --git a/drivers/interconnect/test.rs =
b/drivers/interconnect/test.rs
> new file mode 100644
> index =
0000000000000000000000000000000000000000..f4ba2000d0f1fd2d91aedf8aace0b0b5=
4bfd48f2
> --- /dev/null
> +++ b/drivers/interconnect/test.rs
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +
> +//! Test interconnect consumer driver
> +use kernel::{
> +    c_str, device::Core, icc::*, module_platform_driver, of, =
of::DeviceId, platform, prelude::*,
> +};
> +
> +#[pin_data]
> +struct IccTestConsumerDriver {
> +    #[pin]
> +    path: IccPath,
> +}

I don=E2=80=99t think this does anything useful without PhantomPinned, =
but Benno is
the right person to chime in here.

More importantly though, why do you have #[pin] on IccPath?

> +
> +kernel::of_device_table!(
> +    OF_TABLE,
> +    MODULE_OF_TABLE,
> +    <IccTestConsumerDriver as platform::Driver>::IdInfo,
> +    [(DeviceId::new(c_str!("linux,icc-consumer-test")), ())]
> +);
> +
> +impl platform::Driver for IccTestConsumerDriver {
> +    type IdInfo =3D ();
> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D =
Some(&OF_TABLE);
> +
> +    fn probe(
> +        pdev: &platform::Device<Core>,
> +        _id_info: Option<&Self::IdInfo>,
> +    ) -> Result<Pin<KBox<Self>>> {
> +        let path =3D IccPath::of_get(pdev.as_ref(), None)?;
> +
> +        path.set_bw(
> +            IccBwUnit::from_megabits_per_sec(400),
> +            IccBwUnit::from_megabits_per_sec(800),
> +        )?;
> +
> +        Ok(KBox::pin_init(Self { path }, GFP_KERNEL)?.into())
> +    }
> +}
> +
> +module_platform_driver! {
> +    type: IccTestConsumerDriver,
> +    name: "icc-test-consumer",
> +    authors: ["Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>"],
> +    description: "Test interconnect consumer driver",
> +    license: "GPL",
> +}
>=20
> --=20
> 2.50.1
>=20
>=20

=E2=80=94 Daniel


