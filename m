Return-Path: <linux-pm+bounces-32366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0766AB25C0A
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 08:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768355C579C
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 06:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF522571C6;
	Thu, 14 Aug 2025 06:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSwgMKHi"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEF71F5827
	for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 06:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153708; cv=none; b=JWRvnKFBQ2cT0p6ju0xForLQ7SXg12wZfjVU9Tk+4iHvkF8tXxxpVzh7rFhFtv1jI8Bsja6/KIrDffTaHYGKxmCMp1RQtgcasspC7TChamcZSDXmzS3vbwnj4mc5dfjyoWiWH+kAN9k+00/aNgUGnakR+FPaBycuxVULbeKuff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153708; c=relaxed/simple;
	bh=GCbPMefnp9LdOOPenXhGV0oJ7QE490/uj4sFARHm2Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1Bw1PWBNsIWz2SBIe51tS6yAQXZAD3HyR1j9pJJehVO4FkliFhP6g4UkR/l1To1MW+1iFgJK75/6WpskXytoR2IOMBhM/fyeca44UyMFUjhjGYBr0Ffnia8Eqne2q12eRtctyti/t/vaDSKjG/2M9tv8X4Ya/yaZRp9tPU+bxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSwgMKHi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755153705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9gfDC3XT5JH5+UXZeFk4ANri2tI0Wf8QHIFMwTkbME=;
	b=HSwgMKHigl2T+QYoX2h/Z2DlKJ0+BmkKMdZfKJZiyC6BS/HW8jVRJ1l4Y/REkw1LQhVRZE
	hWj3ua3RuXXUansSxeqy5T/da8qwNs9cpXaDh2E3PWZ7lNVeyP5dC6Ae89sQG3VYckiUOU
	9sWygH9kaw9Ky7I09yH8Wv09sGczInA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-hw9JbX_OM6maTOrF40RKPg-1; Thu, 14 Aug 2025 02:41:42 -0400
X-MC-Unique: hw9JbX_OM6maTOrF40RKPg-1
X-Mimecast-MFC-AGG-ID: hw9JbX_OM6maTOrF40RKPg_1755153701
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9d41cec2cso377580f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Aug 2025 23:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755153701; x=1755758501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9gfDC3XT5JH5+UXZeFk4ANri2tI0Wf8QHIFMwTkbME=;
        b=JDsxir9csJmNC8Yw97vRiwA29xt8CbuM/GARQUnMrf+anNjJHK/FjLPFpyfLFS0i3x
         eYnxiTINWmgxoNeK6EVtAogrtiPM1jPh9HczBGI+3COBuhP6ZhpuYetManLakftJhUiG
         13ksijy4TBCFiA96Zl7+/NcuT0ATQSqAme0DfEuU216XuH6FHZMdY9kUnrBQxpIMb2H2
         lLuUd1KwFn49wTsofCe40ugdTfk5bhKKTAtr3GSlbxgljiVmv2HkmpzxeXGMCUaNy4dD
         JFDcuurY3MEhkmqbzC5iqjJld24dNAdkhPI1UJLxMZV27YLVU4WiHp/BgEg2LVYzUVda
         nHlw==
X-Forwarded-Encrypted: i=1; AJvYcCV4GHsbQLyBUkJwG5VUlWZgB0aqyrXyJQuAFv8c+Fnqvi6D6rkwp3MkBBym4iTLazWtNvp/dxfqtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxajnENV4phRyHYejGMqE4KAvRVe2Dz+p875NLFTZYtF97b1G4e
	HtZYME9/3ZMrkmEn6wdQnUYcGkTxaOZut0jEtp64qFJ7six5j5maIkAERyk5j1SqKCkeI2FMwFS
	Bt2cVAg0PmXkuaIm4G6sFVsvJgFNxqvgZ1TTgmHx4x0FUQil9VgBdpxIK371H
X-Gm-Gg: ASbGncuXkNeIaKrK/B6AcXL8zingFB4l50yyWOdMUhDNBeAaM8OW1BIf0gbp86Sr0Up
	CIynUmis8msXgR3EwT0RzqoDBtAo61ckKnJnYT+LuxdQkYBJp3XED+JoyLXhTlp7OGxD+uU/30F
	dMRMSL0xNmfMGcbe4gahwgit0fuaCK62Fh7uIETzAoKZmjCGmnqnbh1drmz/7eayW4UVjAG3jwM
	3KkpnFn2DGyjDTMNHxblF1RtMhltFsz+HNDRsD9j7W4YOGjNorVdqGCY/u/VAu4t+A74RZ878oM
	f1AtTiR/4fGIiBhuY75mRQSQkFxwpI2qpeYWu6BMQfeIxZhzOznruDzqKeUNorRrqyroH6FhAo3
	WKYU=
X-Received: by 2002:a05:6000:40c7:b0:3b7:8a49:eed0 with SMTP id ffacd0b85a97d-3b9f1a13965mr1378471f8f.22.1755153701048;
        Wed, 13 Aug 2025 23:41:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpLaxNWs2oFsAZSrN9kqR+39ayEAZmpXcMUMLGDC+7HLlsr/ah//p96eCfa0Qd8T4sw00vYQ==
X-Received: by 2002:a05:6000:40c7:b0:3b7:8a49:eed0 with SMTP id ffacd0b85a97d-3b9f1a13965mr1378416f8f.22.1755153700568;
        Wed, 13 Aug 2025 23:41:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bc932sm9252735e9.3.2025.08.13.23.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 23:41:39 -0700 (PDT)
Message-ID: <0f3a72c0-f52f-4ccc-acd8-861824fb762d@redhat.com>
Date: Thu, 14 Aug 2025 08:41:36 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] drm/panic: use `core::ffi::CStr` method names
To: Tamir Duberstein <tamird@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 Javier Martinez Canillas <javierm@redhat.com>, Arnd Bergmann
 <arnd@arndb.de>, Len Brown <lenb@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20250813-core-cstr-fanout-1-v3-0-545c14bc44ff@gmail.com>
 <20250813-core-cstr-fanout-1-v3-1-545c14bc44ff@gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250813-core-cstr-fanout-1-v3-1-545c14bc44ff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2025 17:41, Tamir Duberstein wrote:
> Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
> avoid methods that only exist on the latter.

Thanks, it looks good to me.

Acked-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1075
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>   drivers/gpu/drm/drm_panic_qr.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
> index 09a9b452e8b7..10bc5bb16992 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -948,7 +948,7 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
>           // nul-terminated string.
>           let url_cstr: &CStr = unsafe { CStr::from_char_ptr(url) };
>           let segments = &[
> -            &Segment::Binary(url_cstr.as_bytes()),
> +            &Segment::Binary(url_cstr.to_bytes()),
>               &Segment::Numeric(&data_slice[0..data_len]),
>           ];
>           match EncodedMsg::new(segments, tmp_slice) {
> 


