Return-Path: <linux-pm+bounces-20469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0E1A11C09
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 09:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28C1188305B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 08:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A6C23F294;
	Wed, 15 Jan 2025 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wJLMNqTe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1596C23F286
	for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2025 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736929996; cv=none; b=CZkWJcV7J6ofS7pWO6aPGrZ219jBB4nCJXh3/notg41NdoK1oxBTcj3nun+Tbv1daYuKjokTP3ynczLpXqkCGU2BTqUPunu8Z/R90hS+Om6A9HM+9VOEe6+2r1B8TPX+v9FdZwQS63MhedI5gOi9BZWzR3nOb5a7B2wzZ8zzqM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736929996; c=relaxed/simple;
	bh=cw3S++vdVXpH+g/tLk5BUZ01m6F3t/o8NvHQI8NxdH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phmmJI10gn3YqsW1RzrF+2+Xw1i016SoqHYOnb1oOqK28WJGcKdRKJEC3m3Y2DWbAXCku1t0ZcwQOkAPxDBooeBmj5uBsnduLZPYgUEuStA5hqSxPK4LpVjAqUkfHenDhIqpvuUZcuwfz5nga4I5HU0ZSoqOEE/4tJsEZ3dhC1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wJLMNqTe; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21634338cfdso110041035ad.2
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2025 00:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736929994; x=1737534794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lWWfS7tapqV8kF0uj38k4QfSVdB4DqWDSsuce2QnXMM=;
        b=wJLMNqTeTb9PGQH93NVpunUhNWOLlQz0YoDhLDn0QaSD+S+ftS/muyrqkPmeQwjW8K
         5Nqgxv+6eV9hQ5zJA3hpywgzF7ySMrw1BtDZ3pDKMpl/izZx69h1oBb8NDyL9PbkZ/Xx
         femVD8bRRycjUxTVOun83dmrtcU2/zZtYZcCtajihH85co9xrMIRCAbcQ3VHJ95D7SK6
         U7ohaXEmRh5XoOUWxyJfzlfUNA2FweaxjyDiFgMG/ANTU8vpT3mDnI415bj26Ox11OJR
         5S6vuIHEZKPuqNq0UyPz/W4s5457oStsfE7dqbrq5yQl8yT+8mxxEeUzFrNZbsPdvG83
         +Esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736929994; x=1737534794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWWfS7tapqV8kF0uj38k4QfSVdB4DqWDSsuce2QnXMM=;
        b=o8Lyc5e9VG9cP/6JJwi6K9dnEjNH3Z+Q6n+REKv/cstahnCxEJ/yFXuGmRe/BQGgJE
         V7ICANEw4o8Qqf6uYo0nS22kGNBR/Joie43ApaABMQOLn6HfaxGIKOQnpZEjOrIVNNjR
         pFRgPXIaHfhv6HnF7O398Cv2uVAXyOvWvRLpVbYaOzLpXfiERfweALbLXBtvxWN66hEC
         hRdsIw1aePiNr+23PHEfXf5lVmj2neydmtoxIJ5dEb1k3+snXKuRdNTG5++fAuRn80Vu
         6ERw1UinI9yKb6ijUk5zlsDEQMYPnytLPhmDxCcnsE4ETwSeyLeS7lfMOYFbOE/t0nOW
         FanA==
X-Forwarded-Encrypted: i=1; AJvYcCVkA6Vwvr5mijR6vKuw3ZBhw2fqXm/xrGy8jrOeTNri8Tho0wkFwOils8evbRVdxHmP84wweG9W7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXvWaJ0rHSGjlZg2Vq/W/8jkKTwtmhPDRr6etg8CK9nmzJm6f3
	f/jK0o1I6L0tAPs5KQ7l94IpRTCjiUYoWbtI/vASf9YCA+6iyEe2Oyr5WAhioLo=
X-Gm-Gg: ASbGnctjaJzlg84/QzCCYWdNrhgkFeRD5JQbwaXJLpMqZ7hfYxsx9/PPqWwZTAVQdBV
	xj/2K3yujrK35VobM46j/SmK/bhu+62XyULF7fpgkqVbII+EvK1RMVuGGIPOY/APC19EPkLXAfW
	r3GFnrBwdOjYqf0vAQ5VEIHBbCUdYEqu6uA0h3IlOpMcZyvJwEiOZBsKtrPBQMgyOfKVkRRGIiQ
	v/oOAujMvDCUXhR81GgbMN3sy8byf4hk0/mBDa3L5/bfyPquEHIMXf5NM4=
X-Google-Smtp-Source: AGHT+IEn4mDyp27eGh/C7ybZ+N86WAMwiQGXdJoC6yy6Yg3Vd+MXpgipNrkIRU+8bfpEthVENfvTmg==
X-Received: by 2002:a05:6a00:35c7:b0:725:ef4d:c1bd with SMTP id d2e1a72fcca58-72d21fcec0fmr44185163b3a.19.1736929994413;
        Wed, 15 Jan 2025 00:33:14 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658a7esm8903334b3a.106.2025.01.15.00.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 00:33:13 -0800 (PST)
Date: Wed, 15 Jan 2025 14:03:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH V7 03/16] rust: cpu: Add from_cpu()
Message-ID: <20250115083311.lgw2eu7hz43p2olu@vireshk-i7>
References: <cover.1736766672.git.viresh.kumar@linaro.org>
 <854f7b8c9cbcc7f38fe5ed548290f41224478b40.1736766672.git.viresh.kumar@linaro.org>
 <2025011430-humiliate-expansive-2ea4@gregkh>
 <20250115072050.72oeibi735k3pjdq@vireshk-i7>
 <2025011537-shuffling-unpaved-121a@gregkh>
 <CAH5fLghwAQsriWru-hFs+4pcvmpzZRj7GNC190RL7vi6p9J7Mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLghwAQsriWru-hFs+4pcvmpzZRj7GNC190RL7vi6p9J7Mg@mail.gmail.com>

On 15-01-25, 09:10, Alice Ryhl wrote:
> On the C side, how do you normally prevent uses of the device after it
> became invalid?

IIUC, the per-cpu variable (cpu_sys_devices) that stores the pointers
to CPU devices is cleared and later calls to get_cpu_device() returns
NULL.

The hot-unplug notifiers are fired for existing users (which have
registered for the notifier, like cpufreq), wherein they can remove
per-cpu sysfs files for example.

But otherwise there is no way in the C code to disallow users of the
CPU device pointer, if it is already fetched before the CPU is
removed. The device pointer's memory doesn't get free here though and
it works.

-- 
viresh

