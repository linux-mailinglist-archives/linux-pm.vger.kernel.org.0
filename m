Return-Path: <linux-pm+bounces-23669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F554A57851
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 05:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E1C3B5BA5
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 04:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634BD17A2E6;
	Sat,  8 Mar 2025 04:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QH/DllM7"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B860B1624DC
	for <linux-pm@vger.kernel.org>; Sat,  8 Mar 2025 04:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741408725; cv=none; b=aPQX5gsFu49UgMpSWTSIdsZDCCAYqdyU6Hz2fQ6W9443gKg31KAMarO2As8KVlNrgjwZofygjJykueWmz8W0+ozxMAwPGR8EUzOip/lnSRS/KAhooASPwAjyhLFBnxipvrXTlPjGDaMKw725Nzceabkvhh0b33XxD3Z0HbnO/6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741408725; c=relaxed/simple;
	bh=oYD3dChGCgEhoDXXFBbs/qCCL/9kHoWCs5YB8iY1dkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F622scPBXaQk7WPq4rrZD0s9damSu81OpqPDdYhCTYXnj+dDa2NrkfMzoVfrZaoC9KVf0/qM685M8A1M+2R6j1jN5Ru+r/slHEBpwvgHEW3F5VdJeiHtS/Fs5ye+xbSEhxIXBZBkOKTh55FJBvtiQ8g87oLGZrNsxY7TSm5f8+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QH/DllM7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741408722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rq6OWn+ZGytTT3SEMWGNSgqkOxWtHCEr5x6fELBfolY=;
	b=QH/DllM7e9DX59E+2xY3XYLR7k2c6ueMSlY7iyayrMMX/LF2ZccqbYdH0iB6T0vx7bl4t2
	uzPkt5gv71kHywLJEYodTN5m+xDx8MKE+JoltcLh9iGUMvOqo0GACSvLw50cj8wk684tMQ
	1AqqNW6Rf8MYmw3kpXIlNgvR1179h1c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-jNmvVP_0N5a0y9O_-1wbEg-1; Fri, 07 Mar 2025 23:38:40 -0500
X-MC-Unique: jNmvVP_0N5a0y9O_-1wbEg-1
X-Mimecast-MFC-AGG-ID: jNmvVP_0N5a0y9O_-1wbEg_1741408720
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8f64eb467so25286006d6.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Mar 2025 20:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741408720; x=1742013520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rq6OWn+ZGytTT3SEMWGNSgqkOxWtHCEr5x6fELBfolY=;
        b=JtZQwVhdRsOkXEBictYwvW/opxpK2lZj2h/qJjd5bVQbd1wd3FAZQj4KCNR/iMcT9W
         i6SSEDfE1NFpM19mcRnEUsQYQsmcLjWj3+yQ6K6Ka1ijqHGAoU9iyOP2J1cxhUfLupNW
         BMZhClJyu/XejNQN+p2X286hUyMy394krLgzTeanPl60qNP1W/9CiNSrXCHXfwQFnlFK
         Z6ne3D5fHZarPt+lddqw41lXkfLNboNZwE/dfTQXegMI8gV0MwyDwbLYv25A5Wxg8Vut
         50tIFnzEqs+9K8tPTuFIXfSyurg2KhWSrx/iCVjVd5CE0glAogAa0GqfewMmP0pNA37X
         9BSA==
X-Forwarded-Encrypted: i=1; AJvYcCUdfxDhBmfkUDKR59wJd6vyyUu7P+gT63apujUb37gUAMZrvQXypaAW1t58Z2WNMmIUjMdFs4CTWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6281Lw77IRJYjhegMVCIgZ2KW2sRN9T/8Jd4hVdlAzJ21PTTD
	/zBgS3ifM1c981q8xxDlayj0RNd9zSzWk4vX8PmFEiycRFRI1Kl2eJ5U4G8v81luY05cVJx4hix
	ZNm3v+rzjoCIVXaQJ4dkVkPtqmmFEhp9bEwOnWu1o4qPXC3K4hFkjJndu
X-Gm-Gg: ASbGncteP1jVnTstuNhdpOTwqt3hLmMrxLPpKqfkEdkEe0zHtJjzjGWL/wvEdz0WjYT
	zlbyMRPBRTiVRAi78uag9AzDsphuQHOPnXxdwEXMV9po5K5WnCHn4JYSxAUjHS1YjP6IWX1iJIY
	vCAssABOKMl2kM0arxIOvvwQq/jsuxSUDW9asLhJ2Q2Dg2RO0rCW/XlBRQLXP4Kj+T+NevcsiHd
	fuRVMKsiR/M0p5qaMEl5i+jqyzjwVlpkXspsXARUkuOd8W6qqMAN3R/P5eyn1KL8rBnUj0i5hLP
	ikomJXkXtQ1Tx2gSsuuptvBmgDfQlXjfD8l+iJ9jbHT3UoubwJCqLKXzHG7p3vvMr/fr2xr/kFJ
	E2KxLZMtOzTyMzQuyIPys
X-Received: by 2002:a05:6214:268b:b0:6e8:9e9c:d212 with SMTP id 6a1803df08f44-6e9004f8506mr90389866d6.0.1741408720229;
        Fri, 07 Mar 2025 20:38:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9YmlcyOq5Sq8DJrGB19ZavzadnpX7VLeIbhGmlarP+HC6zAUjLg/COlwKT2yfvezh/i9wkA==
X-Received: by 2002:a05:6214:268b:b0:6e8:9e9c:d212 with SMTP id 6a1803df08f44-6e9004f8506mr90389746d6.0.1741408719976;
        Fri, 07 Mar 2025 20:38:39 -0800 (PST)
Received: from ?IPV6:2603:9001:3d00:5353::14c1? (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a4e6asm27686366d6.55.2025.03.07.20.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 20:38:38 -0800 (PST)
Message-ID: <9b1b2a91-75f3-4ea0-9f55-5cb80ccb9e9f@redhat.com>
Date: Fri, 7 Mar 2025 23:38:34 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] nvmem: core: add nvmem_cell_size()
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250228180326.256058-1-jberring@redhat.com>
 <20250228180326.256058-2-jberring@redhat.com>
 <1167c489-92cb-440e-a2c0-4f47190de5ac@linaro.org>
Content-Language: en-US
From: Jennifer Berringer <jberring@redhat.com>
In-Reply-To: <1167c489-92cb-440e-a2c0-4f47190de5ac@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 3/7/25 12:42, Srinivas Kandagatla wrote:
> Hi Jennifer,
> 
> There is a similar patch on the list, could you take a look and see if that is usable in power reset driver.
> 
> https://lore.kernel.org/lkml/20250306093900.2199442-3-o.rempel@pengutronix.de/T/#m97bbb1870d7140661894a4e806a695e563588524
> 
> --srini

Yes, the nvmem_cell_get_size() function defined in that patch would make my own nvmem_cell_size() function in this patch redundant. I can update my reboot mode driver change to depend on that patch instead of introducing my own function for the same purpose.


