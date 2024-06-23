Return-Path: <linux-pm+bounces-9834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1C7913D1A
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 19:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DCD2817C9
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 17:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC011836C5;
	Sun, 23 Jun 2024 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8RmVo4r"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29418131A;
	Sun, 23 Jun 2024 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719163147; cv=none; b=aq0GXNhQ6XqROX3Gih8J+PJQJuZyimcFpqqqflYrsP2KoZEJhPY0v1+teuzJaNl0wZYhmJuLeaAq4KZ/HzKMrvGA+LBVmvix6NsoXebiDjDoLND6vcY+4giePcNgMvNLV7gXpMSb1H9GPc3JixWq4JNRuSIMjtuH1VaCf/6l+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719163147; c=relaxed/simple;
	bh=qCmxv25bElxRwbeocFVenaYEUgH+efS6kMmPQifYkGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LI+6ZNZQFOSmau/6QYKyan78ILifh0fBEeC1OY5UIh8QsCkH7NV7VCrMaM5deFLZNn0ZOvn1X8er4WAU3f6aLina75eiSc5ngemIaCKs4P+2rZjX1yKH/JXk6lk3D2MNHkmhuoSjFFx9wAPWUqTzFhiFKqy/kv2n2K3rwfWi9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8RmVo4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC35C2BD10;
	Sun, 23 Jun 2024 17:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719163146;
	bh=qCmxv25bElxRwbeocFVenaYEUgH+efS6kMmPQifYkGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I8RmVo4r9Y+gg3aI23UIkqjbsp0km3Xg/xOxf2Ek/WnZXeTc33BCgYbonvTX/maHv
	 u2KQJcJOwb7gYd5gso9J73rhc+MNusgH5vv9EX2cpdK9BWDVK7WMMduvPEYnZ8BRUQ
	 xblfaKv2hV5Fs5LE7qdlhF5ORyDliWu0bAJ1mMqEGCvSZQ9LZ/mJnvFMKKDHMzju9X
	 GQ/IUheSii0Tvrr+OT+Wde3XMYIL1NRERTnJNNaAx03A41A7V0rC2D0gVHtyC4V9eW
	 OqU0/yx8DWXCMqHnuO00vq1vjKk0w82c1l95zYfpbRFEBXN3BBKF3O4jhxDCuws+X+
	 5tX2oCT+OzGtw==
Date: Sun, 23 Jun 2024 18:19:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linus.walleij@linaro.org, sre@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/3] power: supply: ab8500: Clean some error messages
Message-ID: <20240623181900.07381bed@jic23-huawei>
In-Reply-To: <e7ac0fa83c6100cbe4e0efa90cf99291c2423b10.1719037737.git.christophe.jaillet@wanadoo.fr>
References: <cover.1719037737.git.christophe.jaillet@wanadoo.fr>
	<e7ac0fa83c6100cbe4e0efa90cf99291c2423b10.1719037737.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Jun 2024 09:04:26 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> There is an useless extra comma at the end of some error messages, remove
> them.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Odd indeed.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

