Return-Path: <linux-pm+bounces-20078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C82E6A056CE
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 10:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A76161CFB
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 09:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2A11F1305;
	Wed,  8 Jan 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="duR1Rk2w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FBD1D932F
	for <linux-pm@vger.kernel.org>; Wed,  8 Jan 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736328461; cv=none; b=N/XEzwmoMjjfrIxqBCJLDhyZ8+z8mpLKT4npRzK1jwZFiIoJqvSki4HDpwGIKZK0Ecu2Z3QY8LrBXNzuNHnn4X9N6RHZcvzzjz53q7hWDvLaXmCvsPVjIHMK37P03nMwquOitKaiYEMonIQu/1HT3HkE6//lmpfw0/l0LCpg6/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736328461; c=relaxed/simple;
	bh=jVus9tORm8KvuSjonr0l2HkAMicjd4Eb1rJcv3Wo/Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjKQUdc60CF29yGAMFL1B2vLABr5u1fAfR3eX1rd8Ho0RZndy+dJ+koKNpACrntB6F66ckhkx46ltmYLM9p4pYtJYTkGqn8/nSs/4SLFQOgOOGvsox852uX2/z+kBhpvvt4QSu9sUEdTEhIKa2DPAxXfw4hlAg50qrNtc9E2f+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=duR1Rk2w; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21628b3fe7dso237244965ad.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 01:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736328459; x=1736933259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AHm0RBzE9nusKxqQPIPJdzyLuqQMGI1MwErDSccgEsw=;
        b=duR1Rk2wo/FB0Z85EPrtFMFfXD6fLyQvKY5KBfeVAeLL8Z6IcIJ3xmOTTO0zSODL2u
         ar1JYvCSvcf4Ut2Id9KYC0JeuVqW+scZu6SBbUXvO9FxrESeq6htZlNd+yrERT7eDax+
         2HlIeePwL2HThjDMTBzuwWuIHZ3lvjth4uQb+3hr5/mKK+3VuAGW5wepKhY8DTOIAzHK
         dDcaIqbXHTCZUm6Y5jlemr6rze1IVJmKLJg/pJHI4nKKJ+1vnzm03ynT4d7Bh+94GcZE
         XOFJx4L8meOohzOpC9sqMvyzm8qYuWJ0fxbOILw3gXsr/by3pzBSYhshecAGxyom6OtC
         Wm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736328459; x=1736933259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHm0RBzE9nusKxqQPIPJdzyLuqQMGI1MwErDSccgEsw=;
        b=kVmmlaDNRlD/YozRWfygUT6I8wXDb+Bu4doPp78BTp138YR044uIxh1M3JawutxZuU
         Z3Cbgke9w2HQFP3lQe+jhayKozxiGZuUtdZK3ieweefqOCtd4QHr+WbWKMzs7W96Cqet
         IOgGV754PjegLQymaPaPztaxsZ/B3uKPH17ycWoSueZxFub479vHiqsa7nVIhEedmilF
         uJTmL7mBjH/bcweqLh0tbFa3A9/TyeKOTzcXbzQypSzXXsWnW1AJt56NUeKwfVzPPtNI
         ma3u+iLrlnAtCi5TdifEayWyfBm4SV6D+W3Ao2/434fYN62MFV9JUp7LYlISbV1xcj7K
         iTzg==
X-Forwarded-Encrypted: i=1; AJvYcCUxZBHSfy/gzUC5mibSJnAdTWzbV3BUI2VaZJX0gMG0AVsUeGKYNBmyL4Bs3XhYEIDWAt2yAMX+uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxX1WkcgL3NWCyg6NQnnr/flICjGKTMKHYI2erPy22lLrLPcFwj
	cnYflTBCkVQjxHSqPBu1WDUhG/c55Q2sbtCsEGdLZy5Xsf7ThHRZC5iA5lIqVko=
X-Gm-Gg: ASbGncsLiBkLC+sgi0ooqv7PjV5cBysdmz7yqCR99f0nJFOYfGLwUDyHyJYLC8NaxVe
	G2rWgkncwW2hLgCUmawtKTcSEsGeNLQu50BVyzpfBjwkUDRjU8ClIvWM2VFzKZAOZJk0PHyhJbN
	e/T1UVUdQ7mkSlHpM+1fA7WwGTEzFhhABAmvNJfFW9gyzdUWJQ2fY5i5lA1y5Ci6iLt7XS0gteo
	K1pdtbbpi6E9pUSCXb6Y52ob+AlwoGzNkah7xnJPyn6za3cD9kwde3DrQ8=
X-Google-Smtp-Source: AGHT+IFl11h7DflWwx9bWWFuvL2hSbCFHV7kkV1X4l1W+rvTucd+iYu6wUGpzuX+/UKI3PkQh9IjgA==
X-Received: by 2002:a17:902:ce8c:b0:215:711d:d59 with SMTP id d9443c01a7336-21a83f33783mr28520045ad.2.1736328459158;
        Wed, 08 Jan 2025 01:27:39 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca01965sm324039425ad.240.2025.01.08.01.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 01:27:38 -0800 (PST)
Date: Wed, 8 Jan 2025 14:57:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 03/15] cpufreq: Rust implementation doesn't parse
 BIT() macro
Message-ID: <20250108092736.ehimseqpbwraro5g@vireshk-i7>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <9719ba8b3a921bd9f2cb7ebf902c54c708b5409d.1736248242.git.viresh.kumar@linaro.org>
 <2025010752-vagrantly-juiciness-cd81@gregkh>
 <37DAF91C-2A1B-4848-A66F-3B50285AFEBA@collabora.com>
 <20250108065347.k67aqosuefcjdiqi@vireshk-i7>
 <CAH5fLghLxZU5e+7DOXPKordBL_TMXW-_4Bc2E8fkdt_5LSykAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLghLxZU5e+7DOXPKordBL_TMXW-_4Bc2E8fkdt_5LSykAQ@mail.gmail.com>

On 08-01-25, 10:01, Alice Ryhl wrote:
> Change the #define to an enum instead. See commit 3634783be125
> ("binder: use enum for binder ioctls") for an example of this
> strategy.

Thanks Alice. Works with this now:

Subject: [PATCH] cpufreq: Use enum for cpufreq flags that use BIT()

The BIT() macro is too complex for Rust's bindgen to interpret as
integer constants. This can cause issues when generating bindings for
use in Rust. By replacing the `#define` macros with an `enum`, we ensure
that bindgen can properly evaluate these values, enabling their seamless
use in Rust code.

No intentional functional impact.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/cpufreq.h | 96 ++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 45 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 6b882ff4dc24..6f4283007b8c 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -292,11 +292,12 @@ static inline void cpufreq_stats_record_transition(struct cpufreq_policy *policy
  *                      CPUFREQ DRIVER INTERFACE                     *
  *********************************************************************/
 
-#define CPUFREQ_RELATION_L 0  /* lowest frequency at or above target */
-#define CPUFREQ_RELATION_H 1  /* highest frequency below or at target */
-#define CPUFREQ_RELATION_C 2  /* closest frequency to target */
-/* relation flags */
-#define CPUFREQ_RELATION_E BIT(2) /* Get if possible an efficient frequency */
+enum {
+	CPUFREQ_RELATION_L = 0, /* lowest frequency at or above target */
+	CPUFREQ_RELATION_H = BIT(0), /* highest frequency below or at target */
+	CPUFREQ_RELATION_C = BIT(1), /* closest frequency to target */
+	CPUFREQ_RELATION_E = BIT(2), /* Get if possible an efficient frequency */
+};
 
 #define CPUFREQ_RELATION_LE (CPUFREQ_RELATION_L | CPUFREQ_RELATION_E)
 #define CPUFREQ_RELATION_HE (CPUFREQ_RELATION_H | CPUFREQ_RELATION_E)
@@ -418,52 +419,57 @@ struct cpufreq_driver {
 
 /* flags */
 
-/*
- * Set by drivers that need to update internal upper and lower boundaries along
- * with the target frequency and so the core and governors should also invoke
- * the diver if the target frequency does not change, but the policy min or max
- * may have changed.
- */
-#define CPUFREQ_NEED_UPDATE_LIMITS		BIT(0)
+enum {
+	/*
+	 * Set by drivers that need to update internal upper and lower
+	 * boundaries along with the target frequency and so the core and
+	 * governors should also invoke the diver if the target frequency does
+	 * not change, but the policy min or max may have changed.
+	 */
+	CPUFREQ_NEED_UPDATE_LIMITS		= BIT(0),
 
-/* loops_per_jiffy or other kernel "constants" aren't affected by frequency transitions */
-#define CPUFREQ_CONST_LOOPS			BIT(1)
+	/*
+	 * loops_per_jiffy or other kernel "constants" aren't affected by
+	 * frequency transitions.
+	 */
+	CPUFREQ_CONST_LOOPS			= BIT(1),
 
-/*
- * Set by drivers that want the core to automatically register the cpufreq
- * driver as a thermal cooling device.
- */
-#define CPUFREQ_IS_COOLING_DEV			BIT(2)
+	/*
+	 * Set by drivers that want the core to automatically register the
+	 * cpufreq driver as a thermal cooling device.
+	 */
+	CPUFREQ_IS_COOLING_DEV			= BIT(2),
 
-/*
- * This should be set by platforms having multiple clock-domains, i.e.
- * supporting multiple policies. With this sysfs directories of governor would
- * be created in cpu/cpu<num>/cpufreq/ directory and so they can use the same
- * governor with different tunables for different clusters.
- */
-#define CPUFREQ_HAVE_GOVERNOR_PER_POLICY	BIT(3)
+	/*
+	 * This should be set by platforms having multiple clock-domains, i.e.
+	 * supporting multiple policies. With this sysfs directories of governor
+	 * would be created in cpu/cpu<num>/cpufreq/ directory and so they can
+	 * use the same governor with different tunables for different clusters.
+	 */
+	CPUFREQ_HAVE_GOVERNOR_PER_POLICY	= BIT(3),
 
-/*
- * Driver will do POSTCHANGE notifications from outside of their ->target()
- * routine and so must set cpufreq_driver->flags with this flag, so that core
- * can handle them specially.
- */
-#define CPUFREQ_ASYNC_NOTIFICATION		BIT(4)
+	/*
+	 * Driver will do POSTCHANGE notifications from outside of their
+	 * ->target() routine and so must set cpufreq_driver->flags with this
+	 *  flag, so that core can handle them specially.
+	 */
+	CPUFREQ_ASYNC_NOTIFICATION		= BIT(4),
 
-/*
- * Set by drivers which want cpufreq core to check if CPU is running at a
- * frequency present in freq-table exposed by the driver. For these drivers if
- * CPU is found running at an out of table freq, we will try to set it to a freq
- * from the table. And if that fails, we will stop further boot process by
- * issuing a BUG_ON().
- */
-#define CPUFREQ_NEED_INITIAL_FREQ_CHECK	BIT(5)
+	/*
+	 * Set by drivers which want cpufreq core to check if CPU is running at
+	 * a frequency present in freq-table exposed by the driver. For these
+	 * drivers if CPU is found running at an out of table freq, we will try
+	 * to set it to a freq from the table. And if that fails, we will stop
+	 * further boot process by issuing a BUG_ON().
+	 */
+	CPUFREQ_NEED_INITIAL_FREQ_CHECK		= BIT(5),
 
-/*
- * Set by drivers to disallow use of governors with "dynamic_switching" flag
- * set.
- */
-#define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	BIT(6)
+	/*
+	 * Set by drivers to disallow use of governors with "dynamic_switching"
+	 * flag set.
+	 */
+	CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	= BIT(6),
+};
 
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 void cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
-- 
viresh

