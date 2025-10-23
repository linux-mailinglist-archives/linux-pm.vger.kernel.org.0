Return-Path: <linux-pm+bounces-36718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3CAC00C81
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 13:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936C03AFB28
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 11:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4E730E0F9;
	Thu, 23 Oct 2025 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzjIwAqF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9FF3064A7
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219160; cv=none; b=g+u1A8p1fPuPfYalMizy8T7GV7IAnokXz1FrGishLBLx/hJ7R7H3xXFkAgncR18H3kAEuP1HGKw04tAHv4PLsmiwKcbcppGE4O2nDLm9flFDN830yG24J2PY0gMJ6rd/VQm31QQDULbHT5ZLdVnGJoNcJdGCNROaEJFjYiMBAPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219160; c=relaxed/simple;
	bh=azN9cFPaIK+LJvezpMi4n8W0xzLhUdTsw6rk/82Y4Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUh6U5s++wiKb2uuZua3QZzC6uv+g6f1Ec7y2P+WWjTJDIqYcy8agGyX6ACw2EkOCCfk3QMi32NA5MOqN0IVYs9eGqcX0v00SCWqzlIb3hlcYn0aQVktEEoisUyIVTM4DpcFFyiUutyYllT2o+S6X98O5V7aGxpdhBkL9gPzOwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GzjIwAqF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33d28dbced5so974058a91.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 04:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761219158; x=1761823958; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QbT+vL0Cn4CTb6yElLpwHZ54WgDRlKCx3aWeBMwUJrQ=;
        b=GzjIwAqFeZ4Us1IkLeYKFX/B9rnMtdcwRA3Z7JWlL1EeRxoTIPVbXGclFmtVkpycPY
         pEyXmgDZuzqaCmnlV7kzyOoRSlMV+4sKlRsdP9M7W6EtBbVoyD4VtoA48E5+EB+Mmo5M
         +rPeLnkCrh8ua9Vrk7+U3o8pxLOxATEtFFdA3YUC2ngtWANcdBbhG53LtbEbu4WnjrR3
         8if8sTwBEOHGJzAZ/aEdThe1U6V2FpJS5HPA3gk1GDjliGqQFXpHezuS76IoxX0TyJyT
         LQZQ/YcCGpNBxop0WV+RdxVXJZJ5XAmfSKSs8cU/oLzgoea+Vg8S0DImMmP+GeRoDGDf
         9NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219158; x=1761823958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbT+vL0Cn4CTb6yElLpwHZ54WgDRlKCx3aWeBMwUJrQ=;
        b=R6ImbZH+D1ljyDQX+oXNzN0170o+KXXVM4j62eSpoejG/7Z28YNIUrX4Vbzow+p/Sh
         EQpxAp1XnbWYh+p1X3QkY6mYH3v/YurPBZ8NnuWv0IJetWnkvaMqGp535wsH7r5RXIvD
         cOSPU7NOxNCSKEAxq7PAKqdEiih7WYiSm2pwstofrZSHiLnN2cVtY+bzQ4II13JDEdhE
         cq8KvheqXLom1jMZYSZFncQWRfRbLgzoI1qmjEae+ce/k8kNpBO13Aq/qOx1lRjaZrnr
         Hxoo08Mi4GbR3bF8vGyO2KOOFdqYCx2sM7ZtZI6pURV+AtLGVJiinu8caXisPw0yQfb2
         eq6g==
X-Forwarded-Encrypted: i=1; AJvYcCVkaOY0S3OO9TMZWZqNk9M0yTZ4KBXqw4wKJ9jN/fA+Z3nhdpeLMEMiCNvqvLT5oqRTLEpUGNowdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+GdqqTIY6s1lo7TDnh619w3hmba1nWUjANifkXEifaW9DmRmJ
	y7PD4AWiGAMPdtO+LrT0HJLzp36NqsPGDhr2UiGehWJ5Qzo//IjMgyGE1diym3wWpGw=
X-Gm-Gg: ASbGncseMLJgyEA80taY0QQDo4hT/NAVOE0XsMwITT5Zue+g5YAqvmj1N3cXA3NZSzq
	XlsmhvyV0FMEEh4QgoJbjDesw+aDHZYmFJ6r+Vp+HeaDjlcihXmQ2g1p1GRxTIru5MEI1IqWyx1
	zS4manF7S8llGjUg9klghtb4KNd4ce6htgZlLVEPFlThbGK+8E+rvkqWa+M31GmMh2swH4lyxMP
	L7ykq9DQ6RXOaHd01M1DZnyuQ4XC8uJQswlJm8YZGgufFdsnf2uesEB1h2+J7zsdCfgtBmSiQY6
	0Es6mzklkXDAEDXlwNfzYb2amY6F+jjB5bTijBNUEmEZEludRYA+pEyWxkYzZzn2Byy95vicLin
	VDuRqnwKxkvW4gE5SOYXH2h/L+XPc7um7edyojNDbzZApPKdkWKgE0TE2JAglk1eD8aA2r21I2I
	78og==
X-Google-Smtp-Source: AGHT+IG9Mwz3D5ODuzsbIDuuLt6IzRd6uufkDmvzSlsw4AlqElvO+VEf4ssfLY/szdToC/ms2IV8tg==
X-Received: by 2002:a17:90b:4c05:b0:339:ec9c:b275 with SMTP id 98e67ed59e1d1-33bcf84e181mr35547160a91.6.1761219158271;
        Thu, 23 Oct 2025 04:32:38 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff3c1f8csm4042462a91.4.2025.10.23.04.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:32:37 -0700 (PDT)
Date: Thu, 23 Oct 2025 17:02:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tamir Duberstein <tamird@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: opp: simplify callers of `to_c_str_array`
Message-ID: <44k7h2wzksrp4eghvdim5kiq5tsul3p7yhy44d3eii7hyvivch@xx3x762acknd>
References: <20251020-opp-simpler-code-v1-1-04f7f447712f@kernel.org>
 <ms55ue7qqbvoyfhptzu2a5cuthusihtobremhuqfm7lyu7b62o@qasunalgkptl>
 <CAJ-ks9mKiXR-8m_9x_k6YcL64h+QWExkiWCHMFNJbdUYQvPsNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9mKiXR-8m_9x_k6YcL64h+QWExkiWCHMFNJbdUYQvPsNA@mail.gmail.com>

On 22-10-25, 07:22, Tamir Duberstein wrote:
> I believe the `{clk,regulator}_names` vector bindings remain alive for
> the whole scope, even if they are shadowed. See
> https://play.rust-lang.org/?version=stable&mode=debug&edition=2024&gist=800b334c514c2024d7b5e47fc54c1f2d.

I tried to print the name of the regulator and clk in the C code:

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index d67d392e16d4..89b65fe07b99 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2565,6 +2565,8 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
                goto err;
        }

+       pr_info("%s: %d: %s: %s\n", __func__, __LINE__, config->clk_names[0], config->regulator_names[0]);

and I get this:

[    2.358437] core: dev_pm_opp_set_config: 2568: �<��y����<��y���x��: �<��y����<��y���x��



With following diff applied over your patch, it works again:

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 743080e14292..02cb754c4abd 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -444,13 +444,13 @@ pub fn set_supported_hw(mut self, hw: KVec<u32>) -> Result<Self> {
     /// The returned [`ConfigToken`] will remove the configuration when dropped.
     pub fn set(self, dev: &Device) -> Result<ConfigToken> {
         let clk_names = self.clk_names.as_deref().map(to_c_str_array).transpose()?;
-        let clk_names = clk_names.map_or(ptr::null(), |c| c.as_ptr());
+        let clk_names = clk_names.as_ref().map_or(ptr::null(), |c| c.as_ptr());
         let regulator_names = self
             .regulator_names
             .as_deref()
             .map(to_c_str_array)
             .transpose()?;
-        let regulator_names = regulator_names.map_or(ptr::null(), |c| c.as_ptr());
+        let regulator_names = regulator_names.as_ref().map_or(ptr::null(), |c| c.as_ptr());

         let prop_name = self
             .prop_name


and I get:

[    2.460149] core: dev_pm_opp_set_config: 2568: dummy_clk: dummy_reg

-- 
viresh

