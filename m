Return-Path: <linux-pm+bounces-43880-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHzUAbo7q2nIbQEAu9opvQ
	(envelope-from <linux-pm+bounces-43880-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 21:40:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80921227940
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 21:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9BAF3040451
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 20:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6B1480341;
	Fri,  6 Mar 2026 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twajuNQM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871C947F2C5;
	Fri,  6 Mar 2026 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772829621; cv=none; b=QSk0HWSlQlbQr37SrNV+cs2d6kgYbtVk63KwpF5S1DnGPVacUWdcMloIcSLkvgXstVS1zfopoOzkJTjTOR/dneUlhIyt9y9Cu/ebQMWCESjn3VMxwZXT1IdFMNyQTkmivevBA4Dk9EXXQA436SagHrjRqWX52Scad/FaT+k3Axw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772829621; c=relaxed/simple;
	bh=s4RDs0Sy8yYTYYQcL6MMYKDtq50LSWwy8CeiXluWEkg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=pbRN2E9qmnl0F89dpn0nJ9bH3dwl2/01QVZOv7LezQe1NdYL/ndrjQq5iHsfAz4aFF/6iazTcFsXNE/FPXr+iIalR5doMV9XexDZTfnq+8hb0UauMsx6xeShDz2sslExG6WyFy7ilI/9XcOK9HkGpkzVXESKP5wrQsyH953GpKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twajuNQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6A9C4CEF7;
	Fri,  6 Mar 2026 20:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772829621;
	bh=s4RDs0Sy8yYTYYQcL6MMYKDtq50LSWwy8CeiXluWEkg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=twajuNQM4icDyMkN9QMukT/ei+/6SKyeXSIe7jnVpq44xni17dXCaFXBgUNiY8sVD
	 ddGPXIafwTVIzVqrX3VEqW2c1PhfYIsUL+laaCCh11NacnaHAi2ncNEQAtfUoONqQ9
	 262P7xc5hYBr/zGz3cRLGVuai6sQg0oetZFtKut6nf5cWkPnvPAaOR8I7vPFCBlNZs
	 nFjH5PrPZ1ISoCgOySMen/k9D5U6U1gQ4raD4s2CCjE6fwIcD2vo1FoksKxFxtJ2Va
	 ZiydTLoDiFF7Vg7U3Bh7mUm2Wpi9uZSXy6CUk29bfqDyo1vt0ZCVzDghEWuvfsxXsR
	 Y5pv0BiF4dB+A==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Mar 2026 21:40:14 +0100
Message-Id: <DGVZNDKJ7RAG.A66CR0EV9T3P@kernel.org>
Subject: Re: [PATCH v2 3/4] rust: add basic serial device bus abstractions
Cc: "Rob Herring" <robh@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Kari
 Argillander" <kari.argillander@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Boqun Feng"
 <boqun@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <linux-serial@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Markus Probst" <markus.probst@posteo.de>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260306-rust_serdev-v2-0-e9b23b42b255@posteo.de>
 <20260306-rust_serdev-v2-3-e9b23b42b255@posteo.de>
In-Reply-To: <20260306-rust_serdev-v2-3-e9b23b42b255@posteo.de>
X-Rspamd-Queue-Id: 80921227940
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43880-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,garyguo.net,protonmail.com,google.com,umich.edu,gmail.com,linaro.org,ffwll.ch,vger.kernel.org,lists.linux.dev,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri Mar 6, 2026 at 8:35 PM CET, Markus Probst wrote:
> +    extern "C" fn receive_buf_callback(
> +        sdev: *mut bindings::serdev_device,
> +        buf: *const u8,
> +        length: usize,
> +    ) -> usize {
> +        // SAFETY: The serial device bus only ever calls the receive buf=
 callback with a valid
> +        // pointer to a `struct serdev_device`.
> +        //
> +        // INVARIANT: `sdev` is valid for the duration of `receive_buf_c=
allback()`.
> +        let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInternal>=
>() };
> +
> +        // SAFETY: `receive_buf_callback` is only ever called after a su=
ccessful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
> +        // and stored a `Pin<KBox<T>>`.
> +        let data =3D unsafe { sdev.as_ref().drvdata_borrow::<T>() };
> +
> +        // SAFETY:
> +        // - The serial device bus only ever calls the receive buf callb=
ack with a valid pointer to
> +        //   a `struct serdev_device`.
> +        // - `receive_buf_callback` is only ever called after a successf=
ul call to
> +        //   `probe_callback`, hence it's guaranteed that `sdev.private_=
data` is a pointer
> +        //   to a valid `PrivateData`.
> +        let private_data =3D unsafe { &*(*sdev.as_raw()).private_data.ca=
st::<PrivateData>() };
> +
> +        private_data.probe_complete.complete_all();

Will do a full review pass later on, but one quick question in advance:

What is this used for? It is completed here and in probe(), but I don't see=
 it ever
being used to actually wait.

> +
> +        // SAFETY: No one has exclusive access to `private_data.error`.
> +        if unsafe { *private_data.error.get() } {
> +            return length;
> +        }
> +
> +        // SAFETY: `buf` is guaranteed to be non-null and has the size o=
f `length`.
> +        let buf =3D unsafe { core::slice::from_raw_parts(buf, length) };
> +
> +        T::receive(sdev, data, buf)
> +    }
> +}

