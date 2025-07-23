Return-Path: <linux-pm+bounces-31338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2EAB0F266
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 14:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23BD3B1486
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 12:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD602E5B37;
	Wed, 23 Jul 2025 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="bZ2N0mcJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE1C26C3BD;
	Wed, 23 Jul 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753274242; cv=pass; b=sjrFyQ0S2guJ3p+BEVtlVh8cdK5Gi+0seICcbZwyu8Qm/h4L+PFEarZ5zbEC/C/JMQLUe6ZP0fRWSTWUqbwNOuyE8a6dZpMNhxx/7PpsYW7W9LEWzNma4X9oDmnhTKNARD1DDTzTIiCz5UqXECCh5vdAAUMeLO+/t9JbIAvlHP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753274242; c=relaxed/simple;
	bh=2N/Y/ohRsx2NSDf+C+TmukttQ4T9HJGoB01l12MqotQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=M5H7H7EyvhCpEDTUWI2F9Uoa1zRRfddkWfiHgCArTSXy6gxJP2AT9tHLBKIB2x2v7ctG/WXTCNdZPvAM8ywvFDFU/fvd9T1NUYLMqjC2SdVRlCVowec1ICUkQ8XkhYDYKmpBzGRsW074bEd8W4Y5UEcVnxjUw7kCNzF3gNyH3UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=bZ2N0mcJ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753274211; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l5qvDUGiHthNx5QMP6DZw3Qolt/O+UrVleLi7AyU6l+JzzQKtuZEWlJF/jcFaTwVEMbZjXPxvWatEk2L+5Toue/JUoY/M7qvtm9HCsPDjSbQCW6aCAzWWje2qvBCBm4fZkwL1+XAH9WQO8u00aqmmQg3OD1xuyd0ODb0ZwSGhjc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753274211; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sNAt1xjDG8S67TT5jzkK+ZaOsA5YLuo9T5h8Ckdm4jE=; 
	b=ChKE5yhIsiTrQ8jYWb90H1bk3i+Zgvv39n0dR1KSxZhABoGgiV1VS39z/cpbDmvvCow1nbfsSDdoI050lto9YQsGRIpUwQl1qDV7iqfyu3YmlV6KV3wM1uS3td50hslyWrI2Q2DykJRTfaVv02EXwUg8aPcjw7GPK0Jumtgvkak=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753274211;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=sNAt1xjDG8S67TT5jzkK+ZaOsA5YLuo9T5h8Ckdm4jE=;
	b=bZ2N0mcJSpYeMs//jHozeKmu4o18+9A3zEnohBUw0rHzCSz75J3dy659VYBJKMXp
	ATSPosFa/mC999Nhe30BBfmgW6QhyCIVrZqfp10k2nJxrJtQcNJEKhwEqRSp4oZMbwa
	8HPq61tca+4M2v9fWh7aIIgKWNdtUnjy9JDDXmLA=
Received: by mx.zohomail.com with SMTPS id 1753274208177540.169222562024;
	Wed, 23 Jul 2025 05:36:48 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 1/2] rust: Add initial interconnect framework abstractions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250722-topic-icc_rs-v1-1-9da731c14603@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 09:36:32 -0300
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
Message-Id: <3133FE9C-473D-4142-AF38-CA447265C02E@collabora.com>
References: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
 <20250722-topic-icc_rs-v1-1-9da731c14603@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Konrad,

I will be skipping the feedback that was given by others to not sound
repetitive.

> On 22 Jul 2025, at 18:14, Konrad Dybcio <konradybcio@kernel.org> =
wrote:
>=20
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>=20
> Add abstractions for icc_path handling, laying the groundwork for more
> work on the subsystem.

For the sake of reviewers, I think you should add a brief overview of =
what this
code does and what you plan to use it for.

E.g.: can you write a sentence or two about the interconnect subsystem, =
for
example? We can then derive more information from the C documentation if
needed. Also, why do we need icc_path specifically? Why does it have to
come first?=20


>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> MAINTAINERS                     |   1 +
> rust/bindings/bindings_helper.h |   2 +
> rust/kernel/icc.rs              | 225 =
++++++++++++++++++++++++++++++++++++++++
> rust/kernel/lib.rs              |   1 +
> 4 files changed, 229 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index =
ffb35359f1e2d4c286c5afef691f10421a3542a6..fbdbaa3c401d3705974f43bbd47e5a83=
632d33ef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12735,6 +12735,7 @@ F: drivers/interconnect/
> F: include/dt-bindings/interconnect/
> F: include/linux/interconnect-provider.h
> F: include/linux/interconnect.h
> +F: rust/kernel/icc.rs
>=20
> INTERRUPT COUNTER DRIVER
> M: Oleksij Rempel <o.rempel@pengutronix.de>
> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
> index =
84d60635e8a9baef1f1a1b2752dc0fa044f8542f..becfce3fa4794a51d817927376f77df7=
b8b0434d 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -53,6 +53,8 @@
> #include <linux/file.h>
> #include <linux/firmware.h>
> #include <linux/fs.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/interconnect.h>
> #include <linux/ioport.h>
> #include <linux/jiffies.h>
> #include <linux/jump_label.h>
> diff --git a/rust/kernel/icc.rs b/rust/kernel/icc.rs
> new file mode 100644
> index =
0000000000000000000000000000000000000000..3674632866954613749e78bc24b8db6f=
1f3c0369
> --- /dev/null
> +++ b/rust/kernel/icc.rs
> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.

Perhaps this instead [0].

> +
> +//! Interconnect abstractions
> +//!
> +//! (based on clk.rs)
> +//!
> +//! C headers:
> +//! =
[`include/linux/interconnect.h`](srctree/include/linux/interconnect.h)
> +//! =
[`include/linux/interconnect-provider.h`](srctree/include/linux/interconne=
ct-provider.h)
> +//!
> +//! Reference: <https://docs.kernel.org/driver-api/interconnect.html>
> +
> +/// The interconnect framework bandidth unit.
> +///
> +/// Represents a bus bandwidth request in kBps, wrapping a [`u32`] =
value.
> +#[derive(Copy, Clone, PartialEq, Eq, Debug)]
> +pub struct IccBwUnit(pub u32);
> +
> +impl IccBwUnit {
> +    /// Create a new instance from bytes (B)
> +    pub const fn from_bytes_per_sec(bps: u32) -> Self {
> +        Self(bps / 1000)
> +    }
> +
> +    /// Create a new instance from kilobytes (kB) per second
> +    pub const fn from_kilobytes_per_sec(kbps: u32) -> Self {
> +        Self(kbps)
> +    }
> +
> +    /// Create a new instance from megabytes (MB) per second
> +    pub const fn from_megabytes_per_sec(mbps: u32) -> Self {
> +        Self(mbps * 1000)
> +    }
> +
> +    /// Create a new instance from gigabytes (GB) per second
> +    pub const fn from_gigabytes_per_sec(gbps: u32) -> Self {
> +        Self(gbps * 1000 * 1000)
> +    }
> +
> +    /// Create a new instance from bits (b) per second
> +    pub const fn from_bits_per_sec(_bps: u32) -> Self {
> +        Self(1)
> +    }
> +
> +    /// Create a new instance from kilobits (kb) per second
> +    pub const fn from_kilobits_per_sec(kbps: u32) -> Self {
> +        Self(kbps.div_ceil(8))
> +    }
> +
> +    /// Create a new instance from megabits (Mb) per second
> +    pub const fn from_megabits_per_sec(mbps: u32) -> Self {
> +        Self(mbps * 1000 / 8)
> +    }
> +
> +    /// Create a new instance from gigabits (Gb) per second
> +    pub const fn from_gigabits_per_sec(mbps: u32) -> Self {
> +        Self(mbps * 1000 * 1000 / 8)
> +    }
> +
> +    /// Get the bandwidth in bytes (B) per second
> +    pub const fn as_bytes_per_sec(self) -> u32 {
> +        self.0 * 1000
> +    }
> +
> +    /// Get the bandwidth in kilobytes (kB) per second
> +    pub const fn as_kilobytes_per_sec(self) -> u32 {
> +        self.0
> +    }
> +
> +    /// Get the bandwidth in megabytes (MB) per second
> +    pub const fn as_megabytes_per_sec(self) -> u32 {
> +        self.0 / 1000
> +    }
> +
> +    /// Get the bandwidth in gigabytes (GB) per second
> +    pub const fn as_gigabytes_per_sec(self) -> u32 {
> +        self.0 / 1000 / 1000
> +    }
> +
> +    /// Get the bandwidth in bits (b) per second
> +    pub const fn as_bits_per_sec(self) -> u32 {
> +        self.0 * 8 / 1000
> +    }
> +
> +    /// Get the bandwidth in kilobits (kb) per second
> +    pub const fn as_kilobits_per_sec(self) -> u32 {
> +        self.0 * 8
> +    }
> +
> +    /// Get the bandwidth in megabits (Mb) per second
> +    pub const fn as_megabits_per_sec(self) -> u32 {
> +        self.0 * 8 * 1000
> +    }
> +
> +    /// Get the bandwidth in gigabits (Gb) per second
> +    pub const fn as_gigabits_per_sec(self) -> u32 {
> +        self.0 * 8 * 1000 * 1000
> +    }
> +}
> +
> +impl From<IccBwUnit> for u32 {
> +    fn from(bw: IccBwUnit) -> Self {
> +        bw.0
> +    }
> +}
> +

Why is this under CONFIG_INTERCONNECT, but not the code above it?

> +#[cfg(CONFIG_INTERCONNECT)]
> +mod icc_path {
> +    use super::IccBwUnit;
> +    use crate::{
> +        device::Device,
> +        error::{Result, from_err_ptr, to_result},
> +        prelude::*,
> +    };
> +
> +    use core::ptr;
> +
> +    /// A reference-counted interconnect path.
> +    ///
> +    /// Rust abstraction for the C [`struct icc_path`]
> +    ///
> +    /// # Invariants
> +    ///
> +    /// An [`IccPath`] instance holds either a pointer to a valid =
[`struct icc_path`] created by
> +    /// the C portion of the kernel, or a NULL pointer.

Why should this ever be NULL? Can you expand on that in the docs? =
Otherwise
look into NonNull.

> +    ///
> +    /// Instances of this type are reference-counted. Calling =
[`IccPath::of_get`] ensures that the
> +    /// allocation remains valid for the lifetime of the [`IccPath`].

Should this implement AlwaysRefCounted?

> +    ///
> +    /// # Examples
> +    ///
> +    /// The following example demonstrates hwo to obtain and =
configure an interconnect path for
> +    /// a device.

Typo

> +    ///
> +    /// ```
> +    /// use kernel::icc_path::{IccPath, IccBwUnit};
> +    /// use kernel::device::Device;
> +    /// use kernel::error::Result;
> +    ///
> +    /// fn poke_at_bus(dev: &Device) -> Result {
> +    ///     let bus_path =3D IccPath::of_get(dev, =
Some(c_str!("bus")))?;
> +    ///
> +    ///     bus_path.set_bw(
> +    ///         IccBwUnit::from_megabits_per_sec(400),
> +    ///         IccBwUnit::from_megabits_per_sec(800)
> +    ///     )?;
> +    ///
> +    ///     // bus_path goes out of scope and self-disables if there =
are no other users
> +    ///
> +    ///     Ok(())
> +    /// }
> +    /// ```
> +    #[repr(transparent)]
> +    pub struct IccPath(*mut bindings::icc_path);
> +
> +    impl IccPath {
> +        /// Get [`IccPath`] corresponding to a [`Device`]
> +        ///
> +        /// Equivalent to the kernel's of_icc_get() API.

Please either use backticks or provide a link if appropriate.

> +        pub fn of_get(dev: &Device, name: Option<&CStr>) -> =
Result<Self> {
> +            let id =3D name.map_or(ptr::null(), |n| n.as_ptr());
> +
> +            // SAFETY: It's always safe to call [`of_icc_get`]
> +            //
> +            // INVARIANT: The reference count is decremented when =
[`IccPath`] goes out of scope
> +            Ok(Self(from_err_ptr(unsafe {
> +                bindings::of_icc_get(dev.as_raw(), id)
> +            })?))

There=E2=80=99s a lot going on here at once. Can you break this into =
multiple lines?

> +        }
> +
> +        /// Obtain the raw [`struct icc_path`] pointer.
> +        #[inline]
> +        pub fn as_raw(&self) -> *mut bindings::icc_path {
> +            self.0
> +        }

Why should this be needed in drivers?

> +
> +        /// Enable the path.
> +        ///
> +        /// Equivalent to the kernel's icc_enable() API.
> +        #[inline]
> +        pub fn enable(&self) -> Result {
> +            // SAFETY: By the type invariants, self.as_raw() is a =
valid argument for `icc_enable`].
> +            to_result(unsafe { bindings::icc_enable(self.as_raw()) })
> +        }

Should this take &mut? Same for all other functions below.

Note that using &mut may help you implement Sync later.

> +
> +        /// Disable the path.
> +        ///
> +        /// Equivalent to the kernel's icc_disable() API.

Same comment here. You need to ensure that this looks nice in the =
rendered docs.

> +        #[inline]
> +        pub fn disable(&self) -> Result {
> +            // SAFETY: By the type invariants, self.as_raw() is a =
valid argument for `icc_disable`].
> +            to_result(unsafe { bindings::icc_disable(self.as_raw()) =
})
> +        }
> +
> +        /// Set the bandwidth on a path
> +        ///
> +        /// Equivalent to the kernel's icc_set_bw() API.
> +        #[inline]
> +        pub fn set_bw(&self, avg_bw: IccBwUnit, peak_bw: IccBwUnit) =
-> Result {
> +            // SAFETY: By the type invariants, self.as_raw() is a =
valid argument for [`icc_set_bw`].
> +            to_result(unsafe {
> +                bindings::icc_set_bw(
> +                    self.as_raw(),
> +                    avg_bw.as_kilobytes_per_sec(),
> +                    peak_bw.as_kilobytes_per_sec(),
> +                )
> +            })
> +        }
> +    }
> +
> +    impl Drop for IccPath {
> +        fn drop(&mut self) {
> +            // SAFETY: By the type invariants, self.as_raw() is a =
valid argument for [`icc_put`].
> +            unsafe { bindings::icc_put(self.as_raw()) }
> +        }
> +    }
> +}
> +
> +// SAFETY: An `IccPath` is always reference-counted and can be =
released from any thread.
> +unsafe impl Send for IccPath {}
> +
> +#[cfg(CONFIG_INTERCONNECT)]
> +pub use icc_path::*;
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index =
87bcaa1c6b8a6291e71905e8dde60d945b654b98..60f6ac6e79cce57a8538ea0ad48f34f5=
1af91731 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -89,6 +89,7 @@
> pub mod fmt;
> pub mod fs;
> pub mod init;
> +pub mod icc;
> pub mod io;
> pub mod ioctl;
> pub mod jump_label;
>=20
> --=20
> 2.50.1
>=20
>=20

=E2=80=94 Daniel

[0] =
https://spdx.github.io/spdx-spec/v3.0.1/model/Software/Properties/copyrigh=
tText/=

