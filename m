Return-Path: <linux-pm+bounces-28314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ABAAD252F
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 19:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 603E47A4521
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 17:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C9021578D;
	Mon,  9 Jun 2025 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e01OPl9T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28DC27718;
	Mon,  9 Jun 2025 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749491285; cv=none; b=K2sY8wsHiTa8n/0Y+Rne0eUHdCbgpBXE5I+M2pYysm3myEW9d3dgUrwdKHjH2zYz4PegKNpoCU7RV6z6MxNPSMaYZDXObd6vyi4cIkgS/JjMZoKz7nCorlm0uSqNNQfx46ML52+R3KXStv4QLBB11mLHbICKTlqU5ilezs2DEnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749491285; c=relaxed/simple;
	bh=JqpU/ej16AJn7xKB2PN3FrlNtcJWEFUnBgx1d0TLyms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HT4WFm8AZayiL5rTxydc4Df1Y1NykqZykwynahtJh5FAeFoyQbu03cWkD1YfhrYBsY21DWopulk6ZKQFGIyFq0dTrR8Gz0om832swXE4Ng+uiK7mlDJ88I6i9y73LUr5SmwwV17BwqfHDylsjlzIKD7Jy9kCmODidFK+xSXjWLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e01OPl9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A63AC4CEF2;
	Mon,  9 Jun 2025 17:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749491285;
	bh=JqpU/ej16AJn7xKB2PN3FrlNtcJWEFUnBgx1d0TLyms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e01OPl9TtAqR/dXkMERAodgXUvag9wOXfxQV+HFm2EMDJm2bm9yiLs6gZUetSNgG+
	 e39/z3Dyu3bKnMa0R1ENgsL3MTcPOJmoJ8hRe8VzEcfVWFBqVlGcDaMNt+thbcGRHv
	 N6rTKe4ITBULkGEsFEXW0Dd2NTHuYNTkfbxMLf1Jp35/pmAXd1zUg+JYWXdqcLLDop
	 t/sUCcWKwh+EhnPgP53sNOtX1ZkhhI8c+yPkFOhpExRzJz/vjtbnGKkKQQP96QtQkm
	 0n4eL+VS/Lmmys4kIyBmrV1xLAv+3A2kxZFrr/jc5+DZBo8dCkAQzsBeXwo7Fix4D7
	 kG1AqkSf8ny5g==
Message-ID: <826956a9-6a43-404a-8130-11a4a3dc663a@kernel.org>
Date: Mon, 9 Jun 2025 19:47:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: module: remove deprecated author key
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, rafael@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, mcgrof@kernel.org,
 russ.weight@linux.dev, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 leitao@debian.org, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, fujita.tomonori@gmail.com, tamird@gmail.com,
 igor.korotin.linux@gmail.com, anisse@astier.eu, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
References: <20250609122200.179307-1-trintaeoitogc@gmail.com>
 <CANiq72==Xybm956Ete95e3YH7MTresNd3szxLg7GdzvhW1O+jg@mail.gmail.com>
Content-Language: en-US
From: Danilo Krummrich <dakr@kernel.org>
In-Reply-To: <CANiq72==Xybm956Ete95e3YH7MTresNd3szxLg7GdzvhW1O+jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09.06.2025 19:39, Miguel Ojeda wrote:
> On Mon, Jun 9, 2025 at 2:22 PM Guilherme Giacomo Simoes
> <trintaeoitogc@gmail.com> wrote:
>>
>> Now that all in-tree modules have migrated to `authors`, remove:
> 
> Nit: I would have said "most modules", since we have new/remaining
> ones (no need for a new version for this).
> 
> I think this patch is OK -- we could wait to do this more cycles, but
> if we are doing it, then probably the sooner we do it, the simpler.
> 
>>  drivers/cpufreq/rcpufreq_dt.rs        | 2 +-
>>  drivers/gpu/drm/nova/nova.rs          | 2 +-
>>  drivers/gpu/nova-core/nova_core.rs    | 2 +-
>>  rust/kernel/firmware.rs               | 2 +-
>>  samples/rust/rust_configfs.rs         | 2 +-
>>  samples/rust/rust_driver_auxiliary.rs | 2 +-
> 
> Andreas, Danilo, Greg, Viresh: if nobody is against it, I will apply
> it this cycle. Acked-by's for your bits appreciated, of course.

Acked-by: Danilo Krummrich <dakr@kernel.org>


