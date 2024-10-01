Return-Path: <linux-pm+bounces-15010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF9098B84E
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 11:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A111F22D51
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 09:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6444319D8BB;
	Tue,  1 Oct 2024 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tYOhn4dW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E219ADBB
	for <linux-pm@vger.kernel.org>; Tue,  1 Oct 2024 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727774851; cv=none; b=OJvXSH/dWGukRlW0zOeWvzDDUZOKBZuAGfOyH/oR5kQObjhjNGmffN3eNaI1c1wK0/oYILNL5NXliWc2Gud+HByNWiCOnJzfChJZcOx+2OslWQBtb+RVqG3sPM30D6nBKOYGSaMyzlGTPj6r4S/KCWcM7AlzFCD9qHajKU9wBEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727774851; c=relaxed/simple;
	bh=4Ryu3s8DIY9w2EWhCp6rkVgwZ4x/ryar1OMX8E8y0iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8YRV4WTLqZP827pUq8KuM5w71SGEc5gC16hhAKxwBS3GNMCK87fontDE+xKdtAC7ESTwSttl+xy409pp9z68zjzrPZ6CiaFySGBzU4Xjenh1K99zHuCnNZzlli8rKRDvM9vkR1moW2G7OoUCmvHjngYgOW1/Lxk52ClSImyj90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tYOhn4dW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20bb92346caso1684725ad.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Oct 2024 02:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727774849; x=1728379649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Og4qek53uPO62BEgd+L4MRUck7YuRmK/RV5zjsrt7W4=;
        b=tYOhn4dWar/wUg0BdROG1mFnjDOxFii6+/26chQ9Gx9jwQv6qkI8sGJQCuSnmCiogg
         z/Efn4MkXuESJDbLGi/Mwn69362ku7hf4yfy9kOhF7Cu9F4XSNbbizX3867073RRVU57
         EQFf7SrO90k4bxa1Kz4XVPmYNSRFFHEJxr4sekXFGZdifB2W8lYBfeqlPrWWt875Bddq
         htlbfOzFPrLO7D43+dEqMoMCRuKevFr21tzvKauCBzJMFNkWIQMF167nm48fwJ8WBXoO
         ocQDAVpaetWAr6clC9mrDn5iXsnR+Cget+U3EvgPvuE4Hfm6fVPbDz3rk6Uv85P1K2Fh
         cKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727774849; x=1728379649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og4qek53uPO62BEgd+L4MRUck7YuRmK/RV5zjsrt7W4=;
        b=KrPjh0rN/DjfKWBpVeMxU4YpHGYURFT6hTV6ehnmkyVthg1iaFP2O+590cjBrT9hA0
         QtGN0ELoMW2Vjiqo13xQ8+Izv14ns/wd/IRKrVDTCY6RaSRb5FkQ7VpLtHTMV1Lr8LZg
         FQXCM2YRX0WtXLy4QWAvRbUWi/5N5844/fHqIScPBRq/0BEsqyKqKdtQJxf/MvA5urr3
         Ugl1K4P/WrSAU6/qzp1rqumuFJrzhgPJ3zxCHEBKiJcy7PXH7YH+hQCNoZLN+HX1dehx
         UiYgJJdqKHzGj8WHNN/obmgBf/HyG4knGeD7G6oSiY2A28Qp8k9de4Y6xpRdNNzJWjWl
         dA5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGJB/twYQj3J0n1jZfGpdITa3rBvf2NX3kvf+ClvSIw07bvb4g1Jtft7cH/ARH+EiNH3hvHO1HdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0aOSmEo6dyytIifw4dDEs8Yr2UYC0u6d3ykmVaKCtdzKXa9zr
	rZLphPRY3K7TCscBV8SZvXNacj8MW0ztFRMy5OgKo4MGyiXomaQJa0P1ZLHIR8k=
X-Google-Smtp-Source: AGHT+IHVPuoXnXRJAR07g3gOgSdK8XkN/G7SK7XnEebEhiQftRjz1s9ZhVl89pcJe3sb70cJEpliOg==
X-Received: by 2002:a17:902:c411:b0:205:7998:3deb with SMTP id d9443c01a7336-20ba9f188f0mr38962845ad.19.1727774849340;
        Tue, 01 Oct 2024 02:27:29 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db617088sm7700651a12.93.2024.10.01.02.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 02:27:28 -0700 (PDT)
Date: Tue, 1 Oct 2024 14:57:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: opp: operating-points-v2-ti-cpu:
 Describe opp-supported-hw
Message-ID: <20241001092726.rrx2wpu6tu4q4gjf@vireshk-i7>
References: <20240919-b4-opp-dt-binding-fix-v5-1-199216dc0991@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919-b4-opp-dt-binding-fix-v5-1-199216dc0991@ti.com>

On 19-09-24, 18:43, Dhruva Gole wrote:
> It seems like we missed migrating the complete information from the old
> DT binding where we had described what the opp-supported-hw is supposed
> to describe. Hence, bring back the description from the previous binding
> to the current one along with a bit more context on what the values are
> supposed to be.
> 
> Fixes: e576a9a8603f ("dt-bindings: cpufreq: Convert ti-cpufreq to json schema")
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> Changes in v5:
> - Fix the new lines inserted to seperate paragraphs.
> - /eg./example,/
> - Fix Odd line wrapping
> - Link to v4: https://lore.kernel.org/all/20240918173431.GA1833339-robh@kernel.org/

Applied. Thanks.

-- 
viresh

