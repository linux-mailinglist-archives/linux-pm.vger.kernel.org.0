Return-Path: <linux-pm+bounces-11158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1045A932788
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 15:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423131C22BDE
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 13:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC74019AD4F;
	Tue, 16 Jul 2024 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCBLtgfN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4336B19AD6A
	for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136669; cv=none; b=LBlVykoeSfaH88KqTxoT0N1bM/kdaBj4HrwQvbVUlwNcfEETSo2ID/edxFlPasKslAocFHNBpZuGdXMdUnEkGfWE7dcM8GGW7SHh8itxxkMjpr95jRa4ruyGFZX+en8Ulebu/UtWysciIWxF2lpywozLsYuQe37wYLU2aHCWjTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136669; c=relaxed/simple;
	bh=hqJ2gsde7kBN2UEjBf8Yu4hRqEF24u/CNTjZg4K0mfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLMaZHz1E/qZWKGZBxJdRs18pUUcnvfgP/XGKiv3g+J+Od9GQOQIzm6X5JvPm5Ii8JkL7PQWT0OQd+Kj5kHCPiW2oLx1DZ5zzKEjjGPuiSaOSoVt62IdhPZqZWEFGj4sDRCE6re1Sei778qVAVKZhV8QG+I+ms1OmT+pa8esSX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CCBLtgfN; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c6661bca43so2649126eaf.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721136667; x=1721741467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YbLE4D7cXU/UIoD+S3fx1M8F1qQ1hLWwZEveTtY2G4M=;
        b=CCBLtgfNGRy+/M6h4deHX+GafWdjnh098VzSsQiDM2eiBFDAfa92pu5SGUv4GOEgEG
         W6EVcKzrObvHqqE9GoG1K+6Ln1SgA6zJ+sTdxwmat+5HrXxCMeWLqLUwDU2BUkOQWqYN
         GPoeft3IDahqWpjBW5E+7Di10B22/BJId+BIQDdWFSWozoZf+FS1D/eg+86e7Mlt39qp
         gxAF0W0CIKduHA/Sv+imhsaT3nWRqs9hQEzPfoF8JwKeTFPnhtyTnzPFlHwzHgIAxaZa
         /Msfn+eUAy16v4oUK+BVLqKpu9SoBiNnYKC+4ihdhgceY4dEQsDkle0oIjLxOA6b5ip7
         /zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136667; x=1721741467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbLE4D7cXU/UIoD+S3fx1M8F1qQ1hLWwZEveTtY2G4M=;
        b=nrZ5Gg/i0WaPFCWb703eZVHIoIt4BTd0uB5pns0BNVnCDUqcwOjphp5RtCqNF22yGT
         sPE5Rb+62XvtANK0HR2/cJ7EboVz6dLMp2MvGemRtB8+uGL6cEK/FXq2ZeQxpJFDI9Ut
         6zjG2OmNinVVUgBqgDn+wfKUgAiu88XtLEoTryLBO4gyvJvPnFlh0rm0FEQIcMXx6Tb3
         PeOM3IIa/0RcZSQgTmxJMbmiGDouKsHEIHnrgIK6u4NqhdR9/Ixzo4NDr8GJGIAnE43i
         JQmb7RCJ3z/ZFjwYRmnSndxs7EXdm3afYgPdtuzLqBE8u9XuOQCgX7CbP8trAp0yrNrU
         9NUA==
X-Forwarded-Encrypted: i=1; AJvYcCWJA/s1N92AzGRlQsPFidikRWDJ0iKFVhSKpQghOIiJoSYsLZ7LzPBj10y5cG79K3bZYwvFnycsADlUBx474AJ2g1X4FdvYCbk=
X-Gm-Message-State: AOJu0Yyf41g5+tLoOGRjeKQM+8G8EhxTHkrjeXdiXt1wqThVyiH5GkGG
	2Nhy1dBIX/rnr6XvC0XH5ugqwG+zPNC8pwF6Z/2Hc90ue9wz28K+hBSmy05eUqk=
X-Google-Smtp-Source: AGHT+IHD7UKFr107jvXRoZeC323erDVlh/zenswtkNDTafomjSvAL2SvD+wvrcQyfb8I2kV3+PQltw==
X-Received: by 2002:a05:6820:983:b0:5c4:4787:1d4 with SMTP id 006d021491bc7-5d2897f132cmr2339179eaf.5.1721136667369;
        Tue, 16 Jul 2024 06:31:07 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:b5d2:9b28:de1e:aebb])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ce757ab0ddsm1106321eaf.19.2024.07.16.06.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:31:07 -0700 (PDT)
Date: Tue, 16 Jul 2024 08:31:05 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] power: sequencing: fix an invalid pointer dereference
 in error path
Message-ID: <d0b079dd-28bd-4e61-9352-87f5a1b72d09@suswa.mountain>
References: <20240712194004.241939-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712194004.241939-1-brgl@bgdev.pl>

On Fri, Jul 12, 2024 at 09:40:04PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We may end up calling pwrseq_target_free() on a partially initialized
> target object whose unit is either NULL or an ERR_PTR(). Avoid
> dereferencing invalid memory by adding an appropriate check to
> pwrseq_target_free().
> 
> Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-pm/62a3531e-9927-40f8-b587-254a2dfa47ef@stanley.mountain/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> - check for ERR_PTR() in addition to checking for NULL
> - only add the check to pwrseq_target_free() as anywhere else unit is
>   always set and if it's not then it's another bug that needs fixing
> 

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


