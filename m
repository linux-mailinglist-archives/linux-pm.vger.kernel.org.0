Return-Path: <linux-pm+bounces-95-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFABA7F513E
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 21:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9731C20B87
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 20:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9755E5D8FD;
	Wed, 22 Nov 2023 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EzW3sU29"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEDB1BF
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 12:08:45 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3592fadbd7eso545695ab.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 12:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700683725; x=1701288525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vwn5XjAFVwzSFE87KSWGBC++RkG6QZotk9BZhXt0jBU=;
        b=EzW3sU29c+zNuIdvnTBxKyQGsjRWVyxNFlYQAWN2pxeBEfIg4A3SfsYbF6m6Oz2lyy
         5YdmroBIIiY/OvkDmE6LYjQSf+WAyIsjixXJmfOle6kK4voPNpyUg+Q70NMXxp3gQAb8
         SGN5bzLVGlmevfpT0oB472zHbhKXLabxS9IaSymEsdbLfwzLgSjxivkXaaiPMgyApMh/
         hLGuXoGCjkkTBFjbLcUnPktNh0NItCLM0EM9TGGEge0/jpYGvaJasFqgjfH7fu/cFGma
         IjWl+Xl7iZAObdO8gTafZ76hR4SiaBdAsvIKkeRUtHVPTJilIJ0c24w2Ghev8x4WMmMv
         50ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700683725; x=1701288525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vwn5XjAFVwzSFE87KSWGBC++RkG6QZotk9BZhXt0jBU=;
        b=PpeocUVfWXiLF0kj44VLzfH9CmEdSJpoBIsAjmyQSF35RwledgktlhDP+m5WX2mQao
         8UeXZkd8mxsTqDO9yjE/JCj1wMuz5WdsAHtnuguX5Ra29kxYbFegEFsDNYYL6sXGUyBB
         38Fp7sORrsxPL7zDfQOBCl5T4Boxn49OWWQhAzc0fMPf3hWOR4Du9LnoiInpMbGHGjX5
         +qR49pm1sITw14LG8GWHLHDVQOlXvZztpHPeDxJ4/YLQ+0TOjSg2/HruljRHRKoSD27L
         FQkbfv3Gu3zmm03ONk6Zza+SPH75puf8kTFF7Oh6xi13DmejtK8rrGuBweZNsx31Rv3R
         h3hg==
X-Gm-Message-State: AOJu0YxhuORpe4ybNunDkho33VMxB8oNY6IgJYeTojyUAabxjfz0wGAb
	L3gsFi/y0sw4hjfpPnJOOorUYA==
X-Google-Smtp-Source: AGHT+IF2qTlIhwVKEGQ0JFu0xT0lbRPaHgpkk1nP2LZCxYCZLDSL39dT1xuRlbmj8kzVW+/OEqRihw==
X-Received: by 2002:a05:6e02:1345:b0:359:8ddf:5319 with SMTP id k5-20020a056e02134500b003598ddf5319mr3302057ilr.26.1700683725117;
        Wed, 22 Nov 2023 12:08:45 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:3d43:c8e2:1496:e620? ([2605:a601:adae:4500:3d43:c8e2:1496:e620])
        by smtp.gmail.com with ESMTPSA id e7-20020a926907000000b0035acf801fe5sm100939ilc.64.2023.11.22.12.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 12:08:44 -0800 (PST)
Message-ID: <11b0d7cf-b136-454b-a624-d9247bcd2e31@sifive.com>
Date: Wed, 22 Nov 2023 14:08:43 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/21] riscv: convert to use arch_cpu_is_hotpluggable()
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com,
 justin.he@arm.com, James Morse <james.morse@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org,
 linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
 <E1r5R4L-00Ct0d-To@rmk-PC.armlinux.org.uk>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <E1r5R4L-00Ct0d-To@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-11-21 7:45 AM, Russell King (Oracle) wrote:
> Convert riscv to use the arch_cpu_is_hotpluggable() helper rather than
> arch_register_cpu().
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  arch/riscv/kernel/setup.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com> # On HiFive Unmatched


