Return-Path: <linux-pm+bounces-30076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411CCAF7E4F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 19:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE14F3AEC36
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 17:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDAE253356;
	Thu,  3 Jul 2025 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SqepL67E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE442DE712
	for <linux-pm@vger.kernel.org>; Thu,  3 Jul 2025 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751562117; cv=none; b=RpZ4ibAK/HI/5Gt0vJFVzwYFzWSMuntLtiIBNMHuSbCZAulbw4iGwLKlUnhO6a/Tt5V1i7AGFr/ZLrPVv1AtOFqq2AKsc9XXajFkLDnxopVrPxIP3Kb2msx8BQsEYBVzNFKaap7h5QMhIvVUJnvCYEh5pgv62rBOGkJWQGe1EPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751562117; c=relaxed/simple;
	bh=kM7rWDRXYZslPAwvUjI0S1vtqE3V3/5uSDlQQKhDaA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYZbj4B7LmgWRKrBNw5dsHa+jYpRwsKJWGwMWKF6LWxGE/sLtQj7X/LR/lZycy+lA+xVS7YOe7Od4D+AudJSQBcYjIuYEmRvsiWS6LC6fhaoLQxthYHDmRi9vzlJt3ZPP3cFqk3riJRWmwBo2Q1TESuxpF45OjEANLfDHr2BTJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SqepL67E; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4537fdec33bso323895e9.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Jul 2025 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751562114; x=1752166914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tvgXEYfYW5xzDI3GjDygpJ4QKWQyuJxRS6wokAGcsB8=;
        b=SqepL67E69vWyKWmWbFrFHh1ySRSZVxuyKYRxk8Gqdt2l5s6iEy85xJ017ceHT2N4d
         3k39kFBy3p93yxFXmjnHul9Y5nTZT47peEcmO+5uGAz3ow7XV44YdMaXagr0cXmsY01/
         Cq1ssDCrt2sLeZrm/AqnHqOpj0fOfrczwdJYz3Veq88qG6v+iUgt63j0RKO9qF0R8nH9
         lUb4X0WYM+yF7b2fHexgNvwAF+rO6dIVUc/uRgX8jmuuyfwIbFMRcf8pKR6s4e5PoiUI
         7N7wDqwGwV0TRmOD6Q9qV/0APHWO1QSQbYNdjDFfcFNNV3Y3/npGd7RhOSe6acUts1yu
         u4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751562114; x=1752166914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvgXEYfYW5xzDI3GjDygpJ4QKWQyuJxRS6wokAGcsB8=;
        b=Q+ypRmAGhv7tLfkAVJNNyIZBIpDk8Ymfgx5OP5HvxrDNnS8ZmR6NASxuJ5OnH0dJCx
         PKKsOM/Uaubq8jic5qCHqVPZ3vF6MrIhxkXW04RkPmKTOhA9c2Ca8gkhfYSu3T5+9k9u
         usN9iIGsD5DdDq/P61T6zFNAvndhpxH11IB19pQiqV3qK9Dix15bXvfrH/1+3a3MamKX
         yOS12eiXkRFIWu0K0GgW1lscHs1BSgZQE3iNeIo63emcXrMYB2QKzfcmj2gzOAiWC9pl
         kmJFIJkyR9Nro8otJqAbwJifm92V34Hjhum/tZSSW43FqnXYtRUcQqKSBeLZx3LaW0aN
         VXVw==
X-Forwarded-Encrypted: i=1; AJvYcCXll6xaD2hP3Wfu/L1a16Hj9tqCvQCNi1r591Px0/EIhc1DCYgYziAkOxrZVxkWgo+X6s3Psj9F3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm29etfnPmOShyRq/kk4BQiPLiQHLlumUWssTsFanIeBJEHkmE
	vvxyZI0SALQC4fwUnLMWaNIPG3j5actsiKw/9GzNxx77qBBizU+iCVJiix+IUbgCzPHcelwz0w+
	k+90Y
X-Gm-Gg: ASbGncvxQ205lilv/gXDVKqRChIH+NtLJVUqFCKvFohw0aIA8RCU2v/STRVS50FRIz0
	ZiQkFPUgwYkMG0KbBM0a2w4mWN8g7u9gYkjInpigTJsGz1mMKdV6jsMytfUVbYg71o6vkg24VAy
	eTgrkluHZ6mCamLOlspOOFg8ApnGF+Y//T4bcnJZIJBPAd03u8r8qvFT1IV9ylG2pAMdr7WJfgp
	eoBVQUks6EUYNKLdTAgnb7ccrFFahSVqMCVapXllOccawgk0AChy406G0aB1Tn8AmS6mlpwi/LU
	83yaO3BQyD8mSmzadkvzRopsbJoxj4rzCXOJLmmQ1IjDjxN+SCkemAfeIsf9gC7r
X-Google-Smtp-Source: AGHT+IFNvWkN9/aq49nSwsZIeBAVziMrqd9QiExz2sWR+Q9F9wTW5KtDczlzUQmKWE4QnsQoUtU9Ig==
X-Received: by 2002:a05:6000:38a:b0:3a4:f2ed:217e with SMTP id ffacd0b85a97d-3b200f20826mr5442466f8f.42.1751562113092;
        Thu, 03 Jul 2025 10:01:53 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b470caa1b3sm265358f8f.43.2025.07.03.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 10:01:52 -0700 (PDT)
Date: Thu, 3 Jul 2025 19:01:49 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: peterz@infradead.org, rafael@kernel.org, pavel@kernel.org, 
	timvp@google.com, tj@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH next] sched,freezer: prevent tasks from escaping being
 frozen
Message-ID: <n23vsu6y6cjf2vwdbfcjl2mj7venvpzpblncoa7adn3q5r4lph@qsfa3deqtamc>
References: <20250703133427.3301899-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xxkdtvnm4vyog2mi"
Content-Disposition: inline
In-Reply-To: <20250703133427.3301899-1-chenridong@huaweicloud.com>


--xxkdtvnm4vyog2mi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH next] sched,freezer: prevent tasks from escaping being
 frozen
MIME-Version: 1.0

Hello Ridong.

On Thu, Jul 03, 2025 at 01:34:27PM +0000, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> 2. The cgroup freezer state changes to FROZEN (Can be triggered by reading
>    freezer.state).
/o\

> 3. freezing() is called and returns false.

I can see how this can happen because freezer_lock !=3D freezer_mutex.

> As a result, the task may escape being frozen when it should be.
>=20
> To fix this, move the setting of the FROZEN flag to occur just before
> schedule(). This ensures the flag is only set when we're certain the
> task must be switched out.

Is it sufficient? (If the task is spuriously woken up, the next
iteration in that refrigerator loop would be subject to same race, no?)

Thanks,
Michal

--xxkdtvnm4vyog2mi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaGa3ewAKCRB+PQLnlNv4
CCUFAQD3hbnHt6PHs2Vbx/lZ/VZFBWrkd+p+gXvj0bzi1u0q8gEAjE60O9uuwUNi
/Pu7OAzzoXpYzXZHU7/xtTnmlkzJcAU=
=cMjT
-----END PGP SIGNATURE-----

--xxkdtvnm4vyog2mi--

