Return-Path: <linux-pm+bounces-10481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0BC925376
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 08:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9ED51C2548D
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 06:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE61F130A7C;
	Wed,  3 Jul 2024 05:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrZfycr0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D9762FF;
	Wed,  3 Jul 2024 05:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719986383; cv=none; b=sShQ/An5kLVyz3oX9heQgwwf7oEaL1SS4yUeWLEILcpEwLFSUfFQgiW4lLEQjbhq2mPcDJZ8x1zoN4KfiOqlnkcOi00lDLiijlpU/PX5McheH9c2uxB14pEVZAuaOHwLazHiWOXoAY1l7AZUby/fCWZ7q1NGlUuy4v0Sc0dT88w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719986383; c=relaxed/simple;
	bh=V3UHTXHOW8+MOcusBU89t6sFyxHi4KHsJ40uAkd4aZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMVdePUEvPFFAbyZKFO2iyW8/kIRycFNziaIHZwLxMjJZzp2cleN6vyDZOKEssq7inQqZ10m0oAezpU5M5TGy5NxkfU4HcjKrEkckuGrqaOq61Pymrd9tauje4Y2x+GUJ471ax84QCDzuMfCD2B/k3kalPvFn6AYwxUhdL4sJUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrZfycr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9051EC4AF0A;
	Wed,  3 Jul 2024 05:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719986383;
	bh=V3UHTXHOW8+MOcusBU89t6sFyxHi4KHsJ40uAkd4aZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UrZfycr0X6iaw9KZvkpcJQI8ba0ps92qMk753YOZdX+FUDOSPuMR5nVv9HhI3YN1B
	 orcr5cyjgcs5Mh9SE4Yi6LrF7rKqUOxfNxa2Mi18TuqUuY4LMfKhXSk0UWIxJEYV+Z
	 C0vLvsaaFdIxmT0lBhAAlOpvvssqJPEqNUTOWIJBKzk05vumNwS1hyxzZAPgcOZUS1
	 8+pxXHYJ6ePAMT92H0hTyQTe0JKuV+v2UuxXvCP0OBZYa1C7qcITFgGCuT//63KA7f
	 aBY/72bxtufnZ2Zjwrw4t+UedKuHwmEgFomsRoCkpU3gF7miepgKxqZFPwv5idvAzm
	 gvcQkreJgp1Ow==
Date: Wed, 3 Jul 2024 05:59:39 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Sebastian Reichel <sre@kernel.org>, chrome-platform@lists.linux.dev,
	linux-pm@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev
Subject: Re: [PATCH] power: supply: cros_charge-control: Avoid accessing
 attributes out of bounds
Message-ID: <ZoToy98A4lbcUFP-@google.com>
References: <20240702-cros_charge-control-fix-clang-array-bounds-warning-v1-1-ae04d995cd1d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702-cros_charge-control-fix-clang-array-bounds-warning-v1-1-ae04d995cd1d@kernel.org>

On Tue, Jul 02, 2024 at 07:48:48AM -0700, Nathan Chancellor wrote:
> Clang warns (or errors with CONFIG_WERROR=y):
> 
>   drivers/power/supply/cros_charge-control.c:319:2: error: array index 3 is past the end of the array (that has type 'struct attribute *[3]') [-Werror,-Warray-bounds]
>     319 |         priv->attributes[_CROS_CHCTL_ATTR_COUNT] = NULL;
>         |         ^                ~~~~~~~~~~~~~~~~~~~~~~
>   drivers/power/supply/cros_charge-control.c:49:2: note: array 'attributes' declared here
>      49 |         struct attribute *attributes[_CROS_CHCTL_ATTR_COUNT];
>         |         ^
>   1 error generated.
>
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

Thanks!

[1/1] power: supply: cros_charge-control: Avoid accessing attributes out of bounds
      commit: c98f17fec35e46629272226a898ebb0a653ee270

