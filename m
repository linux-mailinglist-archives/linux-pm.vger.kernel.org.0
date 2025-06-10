Return-Path: <linux-pm+bounces-28343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AD2AD30FD
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 10:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246443A3306
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 08:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0E6286D5E;
	Tue, 10 Jun 2025 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpwKaJms"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A332286D47;
	Tue, 10 Jun 2025 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749545769; cv=none; b=BsFTVCfdrl7zCvDb259rVoe4qnInQXUkc5HCvmYbUK6T3tlLs9iU82MhklSOG+UCWq1JVCi5hJ2WvL1aUTgy/O67KkawpICsEZp6VzD013WH4NmwerN79DvQM9YAL1nb2QKjZW7Ia8TQ34HwspYeyg0Zi3j7mKKfeo2dSWZZzpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749545769; c=relaxed/simple;
	bh=FDylNM5QiKDVslap+v69luYbNSSeUxYW7i/sVB1GflI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=D3HEj3ijHCPPDWog6pksKusKIx4huVNE5R+VM/VuNku5INJVOYzzvLoK/OC+cLrIXz1qJKlFGWuWodImWtGFcKCgunk2CLJLhvT7KeKkL/aFL88KiK+nHlDcn6JOibObEF04Wxf/zj6WId911Upr7AFgpSCDWjKfIGkT+oxUwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpwKaJms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907D6C4CEED;
	Tue, 10 Jun 2025 08:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749545768;
	bh=FDylNM5QiKDVslap+v69luYbNSSeUxYW7i/sVB1GflI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=MpwKaJmscN1m61JeMuiBSNXN04P15jq1shwdEt0PGS9cTHeGx6whJWd9idQvI5qF0
	 Y1HX7p8J8Yk9n8V3hxj9UwSRBQwRVTz4DIpRSqpaDlGRmZ2vEQ5BdnvDLiAXJkv1iD
	 rL2lfRcKhaVmjG4DJyjH8ARKr7s5FD5OEBbmnakyhltz1OH09yj2yanzliL4BcQWLG
	 dPpjlqKoyxWOzO48ba76ZkrJflVMutLfxa5W7mnViJu7ocCb2Y3Kl8z2yftNwENtMM
	 VjAd73v8nyQsg9PlDv8pz/Az+2on8uxvxC+2/niv60Uos6Tp3bsdk8IlpeVY3JqJVn
	 rXd5xQpKDqt3w==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Jun 2025 10:56:00 +0200
Message-Id: <DAIQ7MZ4BJN8.3QO6IHT7OPWFS@kernel.org>
Cc: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: module: remove deprecated author key
From: "Benno Lossin" <lossin@kernel.org>
To: "Guilherme Giacomo Simoes" <trintaeoitogc@gmail.com>,
 <rafael@kernel.org>, <viresh.kumar@linaro.org>, <dakr@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <mcgrof@kernel.org>, <russ.weight@linux.dev>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <leitao@debian.org>,
 <gregkh@linuxfoundation.org>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <fujita.tomonori@gmail.com>,
 <tamird@gmail.com>, <igor.korotin.linux@gmail.com>,
 <walmeida@microsoft.com>, <anisse@astier.eu>
X-Mailer: aerc 0.20.1
References: <20250609122200.179307-1-trintaeoitogc@gmail.com>
In-Reply-To: <20250609122200.179307-1-trintaeoitogc@gmail.com>

On Mon Jun 9, 2025 at 2:22 PM CEST, Guilherme Giacomo Simoes wrote:
> Commit 38559da6afb2 ("rust: module: introduce `authors` key") introduced
> a new `authors` key to support multiple module authors, while keeping
> the old `author` key for backward compatibility.
>
> Now that all in-tree modules have migrated to `authors`, remove:
> 1. The deprecated `author` key support from the module macro
> 2. Legacy `author` entries from remaining modules
>
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> ---
>  drivers/cpufreq/rcpufreq_dt.rs        | 2 +-
>  drivers/gpu/drm/nova/nova.rs          | 2 +-
>  drivers/gpu/nova-core/nova_core.rs    | 2 +-
>  rust/kernel/firmware.rs               | 2 +-
>  rust/macros/module.rs                 | 6 ------
>  samples/rust/rust_configfs.rs         | 2 +-
>  samples/rust/rust_driver_auxiliary.rs | 2 +-
>  7 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

