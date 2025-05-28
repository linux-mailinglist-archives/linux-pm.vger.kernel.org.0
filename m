Return-Path: <linux-pm+bounces-27715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 292F1AC60CA
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 06:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93CD97A3943
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 04:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847431E9B31;
	Wed, 28 May 2025 04:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCrtXsn6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA815A848;
	Wed, 28 May 2025 04:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748406321; cv=none; b=S/ldSamR8QdX2ZJnzObTzgeLEMezM6V24bcg6u6YgvfankzmNZWONs590Tl5Ayq42jkF8iyZuDG65bw0IohzgJi2tu4jgfS9zyN8XA4JzvETlMtn5CrIy+IAN0ZWX0LdLJY6uoLFI7tByj3kPdD1GKMTlljUQPI6+Gwso3Gdfwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748406321; c=relaxed/simple;
	bh=mJznzSSN1MuIg6bvYzpsbkoLmjGTnQAh5C3mTHWp394=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpTwkWXfYD5IJsJv0LuoZZM2/ugsA8ZCtZ5W1mQVte2Ver0fOynDPcc+PVxj9Q/es91UzxlSmtEDXbXNxAETm/RGBZWJkF8vrxpKhx/Hqcf1F6KWW64fuT4CAoqxavrmG7ozM4EDgWEnP+aJOoOwV2R7k456rkB01P0y3NT9H9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCrtXsn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6A9C4CEE7;
	Wed, 28 May 2025 04:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748406319;
	bh=mJznzSSN1MuIg6bvYzpsbkoLmjGTnQAh5C3mTHWp394=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCrtXsn6uDBswwMQ+1vhjGTJqtD5J4xLEnzyywc+g1aOWhOv1ZO7wj+87drM2Ns46
	 N+J394jCARw8Oe7Xht1J7V6ix+RE/hDNBI7dyA4Ui6Au0ufRklBqZp+HctrThpMRPW
	 N5OE8WCRjVegO5oS9wOln1TiPMNXXfPi6toXBz4kCywiuMkj5QQLZyABdF+fyZeJzn
	 DPVI0nTgjOfF8SI8VrVSLK/xBsRFM2EjkUa0kjeTOOc5x5EptxyDjFw7OBBk5N2D+g
	 JciTXHwvKJrwLpUJeoHYCa0fcHY8uCB+GUF01cxDOpvFSfkVrW+yGu6Ava8lzuDGOn
	 iQCoN/3hQ0mug==
Date: Tue, 27 May 2025 21:25:03 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Ayush Jain <Ayush.Jain3@amd.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 2/2] x86/fpu: Fix irq_fpu_usable() to return false
 during CPU onlining
Message-ID: <20250528042503.GA1278@sol>
References: <20250520152938.21881-3-ebiggers@kernel.org>
 <202505280957.3efe5bf5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505280957.3efe5bf5-lkp@intel.com>

On Wed, May 28, 2025 at 10:04:39AM +0800, kernel test robot wrote:
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_arch/x86/kernel/fpu/init.c:#fpu__init_cpu" on:
> 
> commit: b88c4665c7f43e1898f695642fd159c6c542e49b ("[PATCH v3 2/2] x86/fpu: Fix irq_fpu_usable() to return false during CPU onlining")
> url: https://github.com/intel-lab-lkp/linux/commits/Eric-Biggers/x86-fpu-Replace-in_kernel_fpu-with-kernel_fpu_allowed/20250520-233322
> patch link: https://lore.kernel.org/all/20250520152938.21881-3-ebiggers@kernel.org/
> patch subject: [PATCH v3 2/2] x86/fpu: Fix irq_fpu_usable() to return false during CPU onlining

Right, this is because fpu__init_cpu() is actually called twice on the boot CPU.
So the WARN_ON_FPU I added in v2 of this patch trips.  Fortunately, the version
that was applied was v1, and it does not have the problematic WARN_ON_FPU.

I wonder if fpu__init_cpu() really should be called twice.  The flow is:

    arch_cpu_finalize_init()
        fpu__init_system()
            fpu__init_system_early_generic()
            fpu__init_cpu()
            fpu__init_system_generic();
            fpu__init_system_xstate_size_legacy();
            fpu__init_system_xstate(fpu_kernel_cfg.max_size);
            fpu__init_task_struct_size();
        fpu__init_cpu()

- Eric

