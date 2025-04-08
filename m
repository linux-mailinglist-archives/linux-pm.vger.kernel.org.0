Return-Path: <linux-pm+bounces-24924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F38AA7F4A6
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 08:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504603A5F89
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 06:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863CD25F994;
	Tue,  8 Apr 2025 06:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kARhbRRa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D962638B8
	for <linux-pm@vger.kernel.org>; Tue,  8 Apr 2025 06:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092426; cv=none; b=qOP6zDleaIJ8veHDdqd3An2aAJ15Bt/8gHmQ647bHoL3G/9+blPNXsxU6BuVGKJtjAMza2xtq2ro+coXlpiC6q+t4OYkb64S5CusBvNaMI7qJBqBQ9+t1lwJY2JOqIPwdJ8+kaEr6gTcopVeyo97O21u63jLdVRN4tfm2PhToqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092426; c=relaxed/simple;
	bh=0HGe9p+Kb3EY1mdIOfIYhz5qJ2LRhzKzm9odfdxCr2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFngmsDvWFTUZZ2fkRj9WvWJuIP6PeqbACG7RCMsJySRut2Wt1Y6yTxjBJgRd4vWsCOMFXM2bYuGPp2QAlIvn0uAnvqjRnwQ4FlNLSG2hFp71L+pgUC9kcpn2kOpCxeOXBn0ETdOYW8kyaMX04Na0ztDTWexg6DmN4TNfNs3t4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kARhbRRa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224341bbc1dso45140875ad.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Apr 2025 23:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744092424; x=1744697224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HInC8FIYBgKJtb+4x4aKQs4vGqqbGkS3dp3Y+WU35lQ=;
        b=kARhbRRazLKhy7b6tvjOg4W//f/9khbfLdIXHnwBFKfaFA+TPrHSOMvq++XELoIgfT
         Di0Hd1705rHF+k3ZQm1By0G7mU3AvyE3ujoqBxBf2eCVxSH3q4nOVWLUhxS5WNhEWiP2
         aJ4C6ozVFzBRJ3XZ3lmIgFrkXHmFbxmTBMutcNGe6mTRX/ati061PZVjBJ5kDK5o2T2U
         ZoRcV/5xA45sl7zLRdDMIGTMnZ1QIkHmBX2CLcYgB9RIQ37iH8KTTKmE+YNOt4GIQ6yd
         rmD0v2g0w2E5lJwCPrJp9WeMJb4pEzOJBa2erj2cI4KE6bxoUekYYf9/SKRBFCcGdSak
         ugAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744092424; x=1744697224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HInC8FIYBgKJtb+4x4aKQs4vGqqbGkS3dp3Y+WU35lQ=;
        b=v34zYsgTbwqbms2lnR7L1QrKPy6D0Ta2E23raEs1PDCoHC91L1OMyHwmumhY0ASwsX
         dWt6upydb02ndhVKONqMyzRqQ6MQkPII4OeGJHFHb7YfxI0BhzQrnnetdJrTpYFGUXry
         0qSh05jTJRYLQQKR0ObsbyAI2zDdWr0skcIhzUs3MSftuiCfeO0w0Vfhx/yQx9djbeks
         IYgUr0rawpAzsymofJ0Bf9onZZ9rQ7f+EZV90Ru/dJkJceeSXbEOc/9RrsMAWF1FDSBP
         UGpCU0e0P/r5zMqXF8MgXDwgNrqrz99NP0300/tVQMacYJUisbB+MuRoLzXM8zAEhZYF
         0K0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJFBAy6s+lkKPXIAhZui5siG7xkKiGyjwHUTaRigOu5diTpRHfJqabtXSkJmp3RdRFWVAdCb6sHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9CP490/SaPzvB9H8inc3Z7nBejxL76dzKlGVYefaD3vMktQT9
	zKH3CaVPq6TRFWPjKW2qi515w3ow6tXc+oIWdS3dEj/kYE/oHwsk4z+HrWNQNsU=
X-Gm-Gg: ASbGncsZDuBewDhLSVHjlIk47gVVgoftdNnMb/O15Btrgl6Y/a6gAbh8t8+AzADXuBh
	GKjBfYce/jF23OphXei69Gg8ll5AZc65I1I+ApLo2VUyrfkEFvyvmNHgIcb12Ucv8ml0n5EKNZo
	JFuRsdFB6CVXe/CXVEkZfDKJNXGSRBCtAoXbfv45XtXa1FtoAcXbe+8ByQ7dZq/z6ksg+4YrkRb
	ofb54q+zHkc9DQXqttZqUW2RxNstYkTyrSvJjvAokNU3vkIdm/iaxsDW37fGb89KXcJsnIgvTCk
	f/Mh7C/5HQo1aqPUOVDzsVmf7tWI/sPigJqg430wA1RfvQ==
X-Google-Smtp-Source: AGHT+IG7e2ArizWP4MnnXCzEngPDf9Y1vLQ4VTedx+YDDLVARLF74VDfkQ2yz9thb5Z0JKu5GA+XJA==
X-Received: by 2002:a17:902:f546:b0:210:fce4:11ec with SMTP id d9443c01a7336-22a95516714mr124727405ad.1.1744092424080;
        Mon, 07 Apr 2025 23:07:04 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e3ecsm92141755ad.198.2025.04.07.23.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 23:07:03 -0700 (PDT)
Date: Tue, 8 Apr 2025 11:37:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Do not enable by default during compile testing
Message-ID: <20250408060701.raoidknorhun5nn3@vireshk-i7>
References: <20250404124006.362723-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404124006.362723-1-krzysztof.kozlowski@linaro.org>

On 04-04-25, 14:40, Krzysztof Kozlowski wrote:
> Enabling the compile test should not cause automatic enabling of all
> drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied. Thanks.

-- 
viresh

