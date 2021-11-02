Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECC24431AA
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 16:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhKBP3K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 11:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbhKBP3K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Nov 2021 11:29:10 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9BDC061714;
        Tue,  2 Nov 2021 08:26:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p16so43741010lfa.2;
        Tue, 02 Nov 2021 08:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=jxKXrb9C6VsXZf+Dit6cYI30qmtRQp1LoPDh3dbd6fE=;
        b=JbaccbSHA2v5YpyT+qKGpnJXPwY9zW/IPLSR2C/s+tFqFh9aUjWsEENQU3C5ULDiQl
         N/CTiIWoRBG8cWIGC2HUhiA0OMwGXX0FU+jczQR0K0PiOjTuOu0qMcmqltLr5F78NXfm
         q0+l2Sofmog1octmSZ1CIUtk6QCz+P/SxR5L2zqsIJVKHeTWK0nGJZ2rgNz4FlQpQHTM
         SBiO0aLmX3cOXulkq4blAoM/kn+5XK8sn/BbgQjHU4YEXwIEekFgU44LlSLv40JGchYO
         +dnTkNwjlsGq/tv/GRkjlIyh2Ovh6DgvKykYVn7jx6vMmbzFhzCI4RMxb6Cri646k2sv
         3dFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jxKXrb9C6VsXZf+Dit6cYI30qmtRQp1LoPDh3dbd6fE=;
        b=zRuYVuL0S7gGsNGs1PzL518l6wVSd603usp+oshooCry2D/xL06ICjcXVVuabnnygZ
         S4H3J+eXllTziYCNmnXiiQAgIlfPgRGpG7ZgqzAS+41M+3QwblO4i0cfti/crc+eNKR8
         JabwyOXZ0bitPkhVyAj5uQsNPOnEXIxBP/UOkSK+6RX3qq1QWlOiSc1qe4uOgCLMNEUk
         Nricd5l83FDXq1n3evwWY1dhECveaCuBkTK41eJKb2BTUuRBy1M+Xt1CsyG5sjqe3hP6
         ZXEDqWPLXPmBeGKsa6aZzjV6xxLaPJVpsXrYo79egMetVa56GkfqRWasTOAHNgdK98Ny
         eFFQ==
X-Gm-Message-State: AOAM533owOvkOCigmYs2N753g7skxZ1inVxK+q47Qoo3jCbpiv0VwEOR
        sKgLv0O41Z6DDyfnUWbRm3c=
X-Google-Smtp-Source: ABdhPJyPu5bNzIzFhqTLtFaO6vmkehwq2zYUaVaQTE5lAd5dGAW2BPMAzvlaH3Vg4G/AW1/If1oA1A==
X-Received: by 2002:a05:6512:2203:: with SMTP id h3mr3018833lfu.324.1635866793420;
        Tue, 02 Nov 2021 08:26:33 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id c1sm482260lfs.241.2021.11.02.08.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 08:26:33 -0700 (PDT)
Message-ID: <53fb3e17-976d-2dea-c954-8efd12c09ee8@gmail.com>
Date:   Tue, 2 Nov 2021 16:26:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:94.0) Gecko/20100101
 Thunderbird/94.0
Subject: Re: [PATCH RFC 0/3] reset: syscon-reboot: add "reg" property support
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20211102152207.11891-1-zajec5@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20211102152207.11891-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02.11.2021 16:22, Rafał Miłecki wrote:
> During my work on MFD binding for Broadcom's TWD block I received
> comment from Rob saying that "syscon-reboot" should use "reg" property.
> I'm not sure if my understanding & implementation are correct so I'm
> sending this RFC.

Reference:
Re: [PATCH 2/2] dt-bindings: mfd: add Broadcom's timer MFD block
Link: https://www.spinics.net/lists/linux-watchdog/msg21255.html
