Return-Path: <linux-pm+bounces-9495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E294790DB6A
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 20:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73920B2398B
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 18:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88C113AD2B;
	Tue, 18 Jun 2024 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Urcbkf9Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7315DBC8
	for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734585; cv=none; b=YXXIx8oqtioERW83u2GwuXMgay+qPrcRQk0daqttKx63iMFqZGf7U6L9zTgfABUQbIOyNjugjlzoMMUvIWQ50LuiULtEOhY2suxTLpzlJ8Pn+URj+McgGajhEXZKxi+PZgq6NltJ7EfXVr7kKSmXSOlNjyS4aLM4eWs4X7wexDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734585; c=relaxed/simple;
	bh=Xd9LdCiuXzzrLb/1qhOQ/z3e3gMYk8tNFBwJ3qgTDjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFl8LAc+WMW48z4ue607h/ylo+Q0Bl0VSRO24t+ik+JTVMOnlW2bKt5Tz0A5RIrPkSGYgMEzyD1yIfEuAb7cf/9w3EOSa2Uvb5JPSxnrZVqYpzebGp7tIVG0DdqDjNsnQ6ycc28od15YufA0VMraleCRcpqG9pSKiJPRI+aLNX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Urcbkf9Z; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7eb721a19c9so25496339f.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 11:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718734583; x=1719339383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ihGEwptJ7lzmt0VyV4WSE4aCrQ7bj97SuSjjG8ijr0=;
        b=Urcbkf9Z0VW2v/rHY3clFjTl7eWtNYbTk1qtg4uANGDdQtbV/KZl4f9FPIyAVAzJYo
         4j3JW0mHcUOL4YcjQSTaWxu2wRlxj5fYfTwuJsSP/7zI85W+/ZPiIyjWvs/wgDMkh2PP
         5uqpdBOKANLlomtBBR+mpHP7h580JdL6hAnvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718734583; x=1719339383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ihGEwptJ7lzmt0VyV4WSE4aCrQ7bj97SuSjjG8ijr0=;
        b=L8FXZaP3TSVwt9suzgPu9DWIR3hbYcEV03YaOA4UK8NMVpoUbip/b0IbTtaI7Bwo6E
         yCW9l3zh+Oh/YEOrJYTfV5lZSGZHINVw8BrHsK0lmFnyKe9gH110dxHYCPYXsEzKSLF2
         wbDvNwjyYI2bOl9GNXfKqEt3Q4sy0xDOgC1/BRGIuQ0LdLoE6Wo3RXb+hawujVeHI9M/
         NrKvSLyLduFH5d/dF1EUe8QBH7vdS8YsLXivSRJwplE/I2igKUGVR1/UghRmZS1RouCj
         6XXGDkLA7XuiAKPGwN62rk0/s09I8U1UFAI0r5ZAZMTP0lnEd2kbnOEqhy15AFY0JAHQ
         7huQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD5AzBt7VSlWIv0ZGeWv7IONmD5UryYcLCiA+16yknsQNNyduqLtUN2uBRY4+plX989l4NO4eIJ+mynegJdcd1FQKr2mfu7l0=
X-Gm-Message-State: AOJu0YzvY24ul4Jqp2UwN81gEefPDBDXGUXkePmvNrSmQtWZocjGEU4U
	/ehP5ccpE+0VINl86xe5aBzJM1xzXhXaX7DlNDJI2XAJzytKloFmoZGAaVs06I0=
X-Google-Smtp-Source: AGHT+IGb+rQjGNQfgCnAjxZWwwQu1kCSqGzROd8BdJkx/6xx0wvnNPwoHeYLw3mTO4nln88oA0f0SQ==
X-Received: by 2002:a92:c7c7:0:b0:375:a361:c796 with SMTP id e9e14a558f8ab-3761d6e5e34mr4173475ab.2.1718734583376;
        Tue, 18 Jun 2024 11:16:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-375d86aad59sm22095535ab.24.2024.06.18.11.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 11:16:23 -0700 (PDT)
Message-ID: <bffea670-8062-4d74-af47-26ef17c76fb0@linuxfoundation.org>
Date: Tue, 18 Jun 2024 12:16:22 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: Add 'help' target to the main Makefile
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240615132613.182899-1-romeusmeister@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240615132613.182899-1-romeusmeister@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/24 07:26, Roman Storozhenko wrote:
> Make "cpupower" building process more user friendly by adding 'help'
> target to the main makefile. This target describes various build
> and cleaning options available to the user.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> V1 -> V2:
>   - Enchanced patch description
>   - Reformat patch
>   - Link v1: https://lore.kernel.org/linux-pm/20240614-make-help-v1-1-513118646b71@gmail.com/
> ---

Applied for Linux 6.11-rc1
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah

