Return-Path: <linux-pm+bounces-20102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B999A05F46
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 15:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326BB166231
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 14:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4A81A9B3F;
	Wed,  8 Jan 2025 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXMjDHd3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D139413B288;
	Wed,  8 Jan 2025 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736347657; cv=none; b=trcdkvFIbSG+Msoqv8TSmVF+J6TS+08Wh8J1q0ZDDah0yXtfj3+UFXHMH/SGDN5w6Cm1w7mL5VdJAbwMNHb9PNYsjRaJdbDJ4fPIl6PCahVOpbRSg8PYFt9icuXYLqwOc+EHwwBai7Cm2CrtsKReGCUvNRwkIBjFT5Mcu3KW000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736347657; c=relaxed/simple;
	bh=e+Rew1/+IskFAor3fp5SMgWB30vK8xHUGH/yMDAg39g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=susKPalOdkCKzlHxTK9nJRDj0uUB+exkG+1aQPiAKBAGJKdhXsSqC4YdocMRJzQdz3qPVIyjkrO7OBZ8M9K1eP6yaM2wzTFjtVFdn8ClZNiHdPp7xJoSIStqFZzvMhkuN1l3OoVi67Z8Y1UUa26Gfb8H/YX/Hmp5KocF8EKbmyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXMjDHd3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef6edddf70so3437622a91.2;
        Wed, 08 Jan 2025 06:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736347654; x=1736952454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XrvM8Six8ydaxJpVIZiA87Kmj21l7gz9Yyl3ltQO2jM=;
        b=iXMjDHd33vtRUz4kpDhB+qOmlN3SNl/TsA1cwcCEpqCJztSe3HHn/ZgkUAX+QCb0G/
         SrFsAb4voX0vT5lSzFAGmDdBxm+ra6m30BBqzHw6QOPxIJocHIsfK2DBoiOdspqjtQxh
         kjrjUy4lv1QYqtXflBiTotGhGD7wOvn1L/sodsyT9MScFf8HVKh1mcdpZsOOrPFh4eIB
         GL04C/D3lprc0kr6JxKIBHiu7gxx3xqG1fTd/8Kv/v+exrmCcIPFkdGdZWoE/3ShKDRL
         w3vMDCudw3aWzd34OsbXH61FTm8aIN2xMcp2mwt3jKj306Q44rtSnlu4+4ZMirPs23i2
         ADLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736347654; x=1736952454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrvM8Six8ydaxJpVIZiA87Kmj21l7gz9Yyl3ltQO2jM=;
        b=pjShf0WnA1sIU76/WXeFlOeo5OYNiih8x5QKEK5f8b8DWCFvnKbEE2/1prbbdm5HlC
         R6OxhrWhOJlLuBM28JAN8//+pRX74h0tbTiVLMoEf5G15D+cXv8+zv5LCk1DwSQwmeh7
         +hjEgSlwZfC8zG8CUDwc05UuFyd+S0qJn7zBXmnnSogsZgKigjyT0fHBBmkm4KKeipNr
         QUuIAFoeBtltCzMO/OCZnwVw/wySlYSst7lxFEug+q1PERcWcF0ckZlamf9ZZklG3dje
         HNhliN950N76vCMJbyhwgm300VpmfKUwCTe1x6/bKcmjxRr+bcM24uvmrUzcWAC/U4Is
         FRDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJjSRp3SpA+jzxQGcuPspQQTx0ndqft30Y0ukg8fDlDNXzhMqH6vcVEWOtn4dn1UPRggGF+dCl0yo=@vger.kernel.org, AJvYcCW9g8HwUOoDNRkNBZRYu07aOUdv8+JIGrxxfEC1L43GOXLIyH7zl8MdxrI77CZsqsJzbLJJ8HudpxGn0Ew=@vger.kernel.org, AJvYcCXiKjQEmpQMtetUvOEamZSmeJ9DO2StAJyUvSU5nAPCxq6tfCqXe/ukQvGT3GkcqUnqn/+jAlTUmS8h/xQvhBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpeOPvvmTO8Sa+Klw61p9hLQI/ZPvdOw4JKYto1mn0fdtNoWGi
	4WtboaXd5eNd7C+qdxjMUgtS3q6HmH4Gm6tVMTaT7R22OcSWpVoBVZ80/KXZckto5tc+Zs7iist
	BxQGb58/V2sCj1tW2V5w5X5v5DtI=
X-Gm-Gg: ASbGncugmGunep0GAUCgfj+K2gIsf0O383ogx5zkJwmgS6HYtPmnT9/X4GwBcz4N2vp
	P6mDN+fnyatnKjFl/n/uqTQwzaHLz7MLrhR5BwQ==
X-Google-Smtp-Source: AGHT+IGb5qMfIQhge16BWoFRTBCHS+EBOBjk2Gu/1asP3aHui/+O9vDW26z9h4/lzmVPW25fwevApa+YhSKEOAXR+sk=
X-Received: by 2002:a17:90a:e18f:b0:2ea:5e0c:2844 with SMTP id
 98e67ed59e1d1-2f548f242b3mr1655387a91.5.1736347652534; Wed, 08 Jan 2025
 06:47:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1736248242.git.viresh.kumar@linaro.org> <9719ba8b3a921bd9f2cb7ebf902c54c708b5409d.1736248242.git.viresh.kumar@linaro.org>
In-Reply-To: <9719ba8b3a921bd9f2cb7ebf902c54c708b5409d.1736248242.git.viresh.kumar@linaro.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 8 Jan 2025 15:47:20 +0100
X-Gm-Features: AbW1kvYm4_Y4SSu6lzP54It6aigq_sqiA1rYRV83Qrp0VEgUeFMnVHMHusor6pI
Message-ID: <CANiq72m20pom+B9EmWO+91E8fjbMEob3JmvHRQ6UaXe_JmatfA@mail.gmail.com>
Subject: Re: [PATCH V6 03/15] cpufreq: Rust implementation doesn't parse BIT() macro
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
	Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	John Baublitz <john.m.baublitz@gmail.com>, 
	Christian Poveda <christian.poveda@ferrous-systems.com>, 
	=?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <emilio@crisal.io>
Content-Type: multipart/mixed; boundary="000000000000094ee6062b32f1b7"

--000000000000094ee6062b32f1b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 12:22=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Rust isn't able to parse the macro for now, avoid using it.

To clarify, the thing that struggles with `BIT` is `bindgen`, rather than R=
ust.

The reason is that `bindgen` does not handle non-trivial `#define`s.
The good news is that recently work got merged to make `bindgen`
understand those that resolve to a constant by (essentially) asking
the C compiler to do so. It is the `--clang-macro-fallback` flag.

Since I wanted to try it within the kernel for a while, I just did so
for `BIT` here, and it works in an standalone header, e.g.

    #include <vdso/bits.h>
    #define CPUFREQ_HAVE_GOVERNOR_PER_POLICY BIT(3)

gives me:

    pub const CPUFREQ_HAVE_GOVERNOR_PER_POLICY: u32 =3D 8;

with `bindgen` 0.71.1.

However, when I tried to make it work within the full kernel build, it
did not work. I reduced it to using `-include` flags for the C
compiler (which we pass a few in the kernel build). I created an issue
at:

    https://github.com/rust-lang/rust-bindgen/issues/3069

I confirmed this by including them manually at the top of the
`bindings_helper.h` file, and it worked (I get about ~1500 extra
constants). It requires something like:

    #ifdef __BINDGEN__
    #include <linux/compiler-version.h>
    #include <linux/kconfig.h>
    #include <linux/compiler_types.h>
    #endif

Plus filtering out the flags.

See the attached patch in case someone wants to play with the feature
and/or improve `bindgen`. Note: it is not a finalized patch at all,
and not intended to be applied, but it gets you a build with the
`CPUFREQ` constant available.

So we could, in principle, use it that way as a workaround. Having
said that, we still need to upgrade the `bindgen` minimum supported
version. So it may be best to simply fix the issue upstream and then
make the upgrade eventually -- `--clang-macro-fallback` is a new
feature anyway.

I also noticed a couple other issues, which strengths that suggestion,
i.e. to try to fix the sharp edges or at least get an agreed
workaround before start using the feature:

  - The dependencies file (`-Wp,-MMD,file.d`) changing behavior: I
filed https://github.com/rust-lang/rust-bindgen/issues/3070.

  - Duplicate definitions created (`pub const`s), e.g. for
https://elixir.bootlin.com/linux/v6.12.6/source/include/uapi/linux/pkt_sche=
d.h#L598-L604.

    I filed https://github.com/rust-lang/rust-bindgen/issues/3071 (it
may be related to
https://github.com/rust-lang/rust-bindgen/issues/3066 too).

I hope that helps!

(Cc'ing John, Christian and Emilio)

Cheers,
Miguel

--000000000000094ee6062b32f1b7
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-TEST-rust-try-clang-macro-feedback.patch"
Content-Disposition: attachment; 
	filename="0001-TEST-rust-try-clang-macro-feedback.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m5o0irp60>
X-Attachment-Id: f_m5o0irp60

RnJvbSAzNWI3NjE3OTk1MjZhNTRjZjYzYmY2YmJiODUwOGZkMDUwOTFiY2JkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWd1ZWwgT2plZGEgPG9qZWRhQGtlcm5lbC5vcmc+CkRhdGU6
IFR1ZSwgNyBKYW4gMjAyNSAxOTo1NToxNyArMDAwMApTdWJqZWN0OiBbUEFUQ0hdIFRFU1QgcnVz
dDogdHJ5IGAtLWNsYW5nLW1hY3JvLWZlZWRiYWNrYAoKT25seSBpbnRlbmRlZCB0byB0ZXN0IHRo
ZSBmZWF0dXJlLCB3aXRoIHdvcmthcm91bmRzIHRoYXQgd2UgcHJvYmFibHkgZG8Kbm90IHdhbnQg
dG8gaGF2ZS4KCk9ubHkgYnJpZWZseSBidWlsZC10ZXN0ZWQgZm9yIGBzcmN0cmVlYCBidWlsZHMu
CgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9ydXN0LWZvci1saW51eC85NzE5YmE4YjNh
OTIxYmQ5ZjJjYjdlYmY5MDJjNTRjNzA4YjU0MDlkLjE3MzYyNDgyNDIuZ2l0LnZpcmVzaC5rdW1h
ckBsaW5hcm8ub3JnLwpTaWduZWQtb2ZmLWJ5OiBNaWd1ZWwgT2plZGEgPG9qZWRhQGtlcm5lbC5v
cmc+Ci0tLQogcnVzdC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTMgKysr
KysrKysrKy0tLQogcnVzdC9iaW5kZ2VuX2luY2x1ZGVfaXNzdWVfd29ya2Fyb3VuZC5oIHwgMTcg
KysrKysrKysrKysrKysrKysKIHJ1c3QvYmluZGdlbl9wYXJhbWV0ZXJzICAgICAgICAgICAgICAg
ICB8IDE5ICsrKysrKysrKysrKysrKysrKysKIHJ1c3QvYmluZGluZ3MvYmluZGluZ3NfaGVscGVy
LmggICAgICAgICB8ICAzICsrKwogcnVzdC9oZWxwZXJzL2hlbHBlcnMuYyAgICAgICAgICAgICAg
ICAgIHwgIDIgKysKIHJ1c3QvdWFwaS91YXBpX2hlbHBlci5oICAgICAgICAgICAgICAgICB8ICAy
ICsrCiA2IGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCiBj
cmVhdGUgbW9kZSAxMDA2NDQgcnVzdC9iaW5kZ2VuX2luY2x1ZGVfaXNzdWVfd29ya2Fyb3VuZC5o
CgpkaWZmIC0tZ2l0IGEvcnVzdC9NYWtlZmlsZSBiL3J1c3QvTWFrZWZpbGUKaW5kZXggOWRhOTA0
MmZkNjI3Li4zZDNjMWUyYzBlNmUgMTAwNjQ0Ci0tLSBhL3J1c3QvTWFrZWZpbGUKKysrIGIvcnVz
dC9NYWtlZmlsZQpAQCAtMjc4LDcgKzI3OCwxMSBAQCBlbmRpZgogIyBwcm90b3R5cGVzIGZvciBm
dW5jdGlvbnMgbGlrZSBgbWVtY3B5YCAtLSBpZiB0aGlzIGZsYWcgaXMgbm90IHBhc3NlZCwKICMg
YGJpbmRnZW5gLWdlbmVyYXRlZCBwcm90b3R5cGVzIHVzZSBgY191bG9uZ2Agb3IgYGNfdWludGAg
ZGVwZW5kaW5nIG9uCiAjIGFyY2hpdGVjdHVyZSBpbnN0ZWFkIG9mIGdlbmVyYXRpbmcgYHVzaXpl
YC4KLWJpbmRnZW5fY19mbGFnc19maW5hbCA9ICQoYmluZGdlbl9jX2ZsYWdzX2x0bykgLWZuby1i
dWlsdGluIC1EX19CSU5ER0VOX18KK2JpbmRnZW5fY19mbGFnc19maW5hbCA9ICQoZmlsdGVyLW91
dCAtaW5jbHVkZSBcCisJJWluY2x1ZGUvbGludXgvY29tcGlsZXItdmVyc2lvbi5oIFwKKwklaW5j
bHVkZS9saW51eC9rY29uZmlnLmggXAorCSVpbmNsdWRlL2xpbnV4L2NvbXBpbGVyX3R5cGVzLmgg
XAorLCQoYmluZGdlbl9jX2ZsYWdzX2x0bykpIC1mbm8tYnVpbHRpbiAtRF9fQklOREdFTl9fCiAK
IHF1aWV0X2NtZF9iaW5kZ2VuID0gQklOREdFTiAkQAogICAgICAgY21kX2JpbmRnZW4gPSBcCkBA
IC0yODgsMTkgKzI5MiwyMiBAQCBxdWlldF9jbWRfYmluZGdlbiA9IEJJTkRHRU4gJEAKIAkJLW8g
JEAgLS0gJChiaW5kZ2VuX2NfZmxhZ3NfZmluYWwpIC1ETU9EVUxFIFwKIAkJJChiaW5kZ2VuX3Rh
cmdldF9jZmxhZ3MpICQoYmluZGdlbl90YXJnZXRfZXh0cmEpCiAKKyMgVE9ETzogcHJvcGVyIHdv
cmthcm91bmQgZm9yIGAtLWNsYW5nLW1hY3JvLWZhbGxiYWNrYCBpbnRlcmFjdGlvbiB3aXRoIGAt
V3AsLU1NRCxmaWxlLmRgOgorIworIyAgICAgaHR0cHM6Ly9naXRodWIuY29tL3J1c3QtbGFuZy9y
dXN0LWJpbmRnZW4vaXNzdWVzLzMwNzAKICQob2JqKS9iaW5kaW5ncy9iaW5kaW5nc19nZW5lcmF0
ZWQucnM6IHByaXZhdGUgYmluZGdlbl90YXJnZXRfZmxhZ3MgPSBcCiAgICAgJChzaGVsbCBncmVw
IC1FdiAnXiN8XiQkJyAkKHNyYykvYmluZGdlbl9wYXJhbWV0ZXJzKQogJChvYmopL2JpbmRpbmdz
L2JpbmRpbmdzX2dlbmVyYXRlZC5yczogcHJpdmF0ZSBiaW5kZ2VuX3RhcmdldF9leHRyYSA9IDsg
XAogICAgIHNlZCAtRWkgJ3MvcHViIGNvbnN0IFJVU1RfQ09OU1RfSEVMUEVSXyhbYS16QS1aMC05
X10qKS9wdWIgY29uc3QgXDEvZycgJEAKICQob2JqKS9iaW5kaW5ncy9iaW5kaW5nc19nZW5lcmF0
ZWQucnM6ICQoc3JjKS9iaW5kaW5ncy9iaW5kaW5nc19oZWxwZXIuaCBcCiAgICAgJChzcmMpL2Jp
bmRnZW5fcGFyYW1ldGVycyBGT1JDRQotCSQoY2FsbCBpZl9jaGFuZ2VkX2RlcCxiaW5kZ2VuKQor
CSQoY2FsbCBpZl9jaGFuZ2VkLGJpbmRnZW4pCiAKICQob2JqKS91YXBpL3VhcGlfZ2VuZXJhdGVk
LnJzOiBwcml2YXRlIGJpbmRnZW5fdGFyZ2V0X2ZsYWdzID0gXAogICAgICQoc2hlbGwgZ3JlcCAt
RXYgJ14jfF4kJCcgJChzcmMpL2JpbmRnZW5fcGFyYW1ldGVycykKICQob2JqKS91YXBpL3VhcGlf
Z2VuZXJhdGVkLnJzOiAkKHNyYykvdWFwaS91YXBpX2hlbHBlci5oIFwKICAgICAkKHNyYykvYmlu
ZGdlbl9wYXJhbWV0ZXJzIEZPUkNFCi0JJChjYWxsIGlmX2NoYW5nZWRfZGVwLGJpbmRnZW4pCisJ
JChjYWxsIGlmX2NoYW5nZWQsYmluZGdlbikKIAogIyBTZWUgYENGTEFHU19SRU1PVkVfaGVscGVy
cy5vYCBhYm92ZS4gSW4gYWRkaXRpb24sIENsYW5nIG9uIEMgZG9lcyBub3Qgd2FybgogIyB3aXRo
IGAtV21pc3NpbmctZGVjbGFyYXRpb25zYCAodW5saWtlIEdDQyksIHNvIGl0IGlzIG5vdCBzdHJp
Y3RseSBuZWVkZWQgaGVyZQpkaWZmIC0tZ2l0IGEvcnVzdC9iaW5kZ2VuX2luY2x1ZGVfaXNzdWVf
d29ya2Fyb3VuZC5oIGIvcnVzdC9iaW5kZ2VuX2luY2x1ZGVfaXNzdWVfd29ya2Fyb3VuZC5oCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uZDNhZDUxMjEwNzMyCi0tLSAv
ZGV2L251bGwKKysrIGIvcnVzdC9iaW5kZ2VuX2luY2x1ZGVfaXNzdWVfd29ya2Fyb3VuZC5oCkBA
IC0wLDAgKzEsMTcgQEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovCisv
KgorICogV29ya2Fyb3VuZCBgYmluZGdlbmAncyBgLS1jbGFuZy1tYWNyby1mYWxsYmFja2AgaXNz
dWUgd2l0aCBgLWluY2x1ZGVgOgorICoKKyAqICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9ydXN0LWxh
bmcvcnVzdC1iaW5kZ2VuL2lzc3Vlcy8zMDY5CisgKi8KKworI2lmbmRlZiBfX0JJTkRHRU5fSU5D
TFVERV9JU1NVRV9XT1JLQVJPVU5EX0gKKyNkZWZpbmUgX19CSU5ER0VOX0lOQ0xVREVfSVNTVUVf
V09SS0FST1VORF9ICisKKyNpZmRlZiBfX0JJTkRHRU5fXworI2luY2x1ZGUgPGxpbnV4L2NvbXBp
bGVyLXZlcnNpb24uaD4KKyNpbmNsdWRlIDxsaW51eC9rY29uZmlnLmg+CisjaW5jbHVkZSA8bGlu
dXgvY29tcGlsZXJfdHlwZXMuaD4KKyNlbmRpZiAvKiBfX0JJTkRHRU5fXyAqLworCisjZW5kaWYg
LyogX19CSU5ER0VOX0lOQ0xVREVfSVNTVUVfV09SS0FST1VORF9IICovCmRpZmYgLS1naXQgYS9y
dXN0L2JpbmRnZW5fcGFyYW1ldGVycyBiL3J1c3QvYmluZGdlbl9wYXJhbWV0ZXJzCmluZGV4IDBm
OTZhZjhiOWE3Zi4uMzQ1MmI4OGUxYTFjIDEwMDY0NAotLS0gYS9ydXN0L2JpbmRnZW5fcGFyYW1l
dGVycworKysgYi9ydXN0L2JpbmRnZW5fcGFyYW1ldGVycwpAQCAtMSw1ICsxLDI0IEBACiAjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCiAKKy0tY2xhbmctbWFjcm8tZmFsbGJhY2sK
KworIyBXb3JrYXJvdW5kIGZvciBgLS1jbGFuZy1tYWNyby1mYWxsYmFja2AgZHVwbGljYXRlIGRl
ZmluaXRpb25zOgorIworIyAgICAgaHR0cHM6Ly9naXRodWIuY29tL3J1c3QtbGFuZy9ydXN0LWJp
bmRnZW4vaXNzdWVzLzMwNzEKKy0tYmxvY2tsaXN0LWl0ZW0gX19UQ19NUVBSSU9fTU9ERV9NQVgK
Ky0tYmxvY2tsaXN0LWl0ZW0gX19UQ19NUVBSSU9fU0hBUEVSX01BWAorLS1ibG9ja2xpc3QtaXRl
bSBUQ0FfUE9MSUNFX1JFU1VMVAorLS1ibG9ja2xpc3QtaXRlbSBCUEZfRl9MSU5LCistLWJsb2Nr
bGlzdC1pdGVtIFBBR0VfU0laRQorLS1ibG9ja2xpc3QtaXRlbSBHRlBfQVRPTUlDCistLWJsb2Nr
bGlzdC1pdGVtIEdGUF9LRVJORUwKKy0tYmxvY2tsaXN0LWl0ZW0gR0ZQX0tFUk5FTF9BQ0NPVU5U
CistLWJsb2NrbGlzdC1pdGVtIEdGUF9OT1dBSVQKKy0tYmxvY2tsaXN0LWl0ZW0gX19HRlBfWkVS
TworLS1ibG9ja2xpc3QtaXRlbSBfX0dGUF9ISUdITUVNCistLWJsb2NrbGlzdC1pdGVtIF9fR0ZQ
X05PV0FSTgorLS1ibG9ja2xpc3QtaXRlbSBCTEtfRkVBVF9ST1RBVElPTkFMCisKICMgV2Ugd2Fu
dCB0byBtYXAgdGhlc2UgdHlwZXMgdG8gYGlzaXplYC9gdXNpemVgIG1hbnVhbGx5LCBpbnN0ZWFk
IG9mCiAjIGRlZmluZSB0aGVtIGFzIGBpbnRgL2Bsb25nYCBkZXBlbmRpbmcgb24gcGxhdGZvcm0g
Yml0d2lkdGguCiAtLWJsb2NrbGlzdC10eXBlIF9fa2VybmVsX3M/c2l6ZV90CmRpZmYgLS1naXQg
YS9ydXN0L2JpbmRpbmdzL2JpbmRpbmdzX2hlbHBlci5oIGIvcnVzdC9iaW5kaW5ncy9iaW5kaW5n
c19oZWxwZXIuaAppbmRleCA1YzRkZmUyMmY0MWEuLmU5OGJhODdlZmQ0YiAxMDA2NDQKLS0tIGEv
cnVzdC9iaW5kaW5ncy9iaW5kaW5nc19oZWxwZXIuaAorKysgYi9ydXN0L2JpbmRpbmdzL2JpbmRp
bmdzX2hlbHBlci5oCkBAIC02LDEwICs2LDEzIEBACiAgKiBTb3J0ZWQgYWxwaGFiZXRpY2FsbHku
CiAgKi8KIAorI2luY2x1ZGUgIi4uL2JpbmRnZW5faW5jbHVkZV9pc3N1ZV93b3JrYXJvdW5kLmgi
CisKICNpbmNsdWRlIDxrdW5pdC90ZXN0Lmg+CiAjaW5jbHVkZSA8bGludXgvYmxrLW1xLmg+CiAj
aW5jbHVkZSA8bGludXgvYmxrX3R5cGVzLmg+CiAjaW5jbHVkZSA8bGludXgvYmxrZGV2Lmg+Cisj
aW5jbHVkZSA8bGludXgvY3B1ZnJlcS5oPgogI2luY2x1ZGUgPGxpbnV4L2NyZWQuaD4KICNpbmNs
dWRlIDxsaW51eC9lcnJuYW1lLmg+CiAjaW5jbHVkZSA8bGludXgvZXRodG9vbC5oPgpkaWZmIC0t
Z2l0IGEvcnVzdC9oZWxwZXJzL2hlbHBlcnMuYyBiL3J1c3QvaGVscGVycy9oZWxwZXJzLmMKaW5k
ZXggZGNmODI3YTYxYjUyLi40MDQ4YWZlMTAwOGYgMTAwNjQ0Ci0tLSBhL3J1c3QvaGVscGVycy9o
ZWxwZXJzLmMKKysrIGIvcnVzdC9oZWxwZXJzL2hlbHBlcnMuYwpAQCAtNyw2ICs3LDggQEAKICAq
IFNvcnRlZCBhbHBoYWJldGljYWxseS4KICAqLwogCisjaW5jbHVkZSAiLi4vYmluZGdlbl9pbmNs
dWRlX2lzc3VlX3dvcmthcm91bmQuaCIKKwogI2luY2x1ZGUgImJsay5jIgogI2luY2x1ZGUgImJ1
Zy5jIgogI2luY2x1ZGUgImJ1aWxkX2Fzc2VydC5jIgpkaWZmIC0tZ2l0IGEvcnVzdC91YXBpL3Vh
cGlfaGVscGVyLmggYi9ydXN0L3VhcGkvdWFwaV9oZWxwZXIuaAppbmRleCA3NmQzZjEwM2U3NjQu
LmU1NGQ0MTc3ZDIwZSAxMDA2NDQKLS0tIGEvcnVzdC91YXBpL3VhcGlfaGVscGVyLmgKKysrIGIv
cnVzdC91YXBpL3VhcGlfaGVscGVyLmgKQEAgLTYsNiArNiw4IEBACiAgKiBTb3J0ZWQgYWxwaGFi
ZXRpY2FsbHkuCiAgKi8KIAorI2luY2x1ZGUgIi4uL2JpbmRnZW5faW5jbHVkZV9pc3N1ZV93b3Jr
YXJvdW5kLmgiCisKICNpbmNsdWRlIDx1YXBpL2FzbS1nZW5lcmljL2lvY3RsLmg+CiAjaW5jbHVk
ZSA8dWFwaS9saW51eC9tZGlvLmg+CiAjaW5jbHVkZSA8dWFwaS9saW51eC9taWkuaD4KLS0gCjIu
NDcuMQoK
--000000000000094ee6062b32f1b7--

