Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3C011583E
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 21:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfLFUn5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 15:43:57 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46461 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfLFUn5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2019 15:43:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id z17so8988939ljk.13
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2019 12:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oF+xlo1sx9gytHOVJmZzD5EHDYm2UDoLMUn75V8RhEs=;
        b=FI3uXTGCTF/CsvRtjzUm5SGnAxOj8iYUwPwy84nNUJAQJIy5Z6jDPZ43JCM/HizVKg
         wjalGmSGIL0vznEvGNI1fgY2QOncXYDyRCXqkbhLZL8a9TB613Tjf+UBXDFFD4K0KOTd
         X/6uFMhEOqGq73YaEAyW74x0y8WYPWnVAscv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oF+xlo1sx9gytHOVJmZzD5EHDYm2UDoLMUn75V8RhEs=;
        b=BRwfQykbZa5xvslPNaQRa9YjSyN4TomB2KvZN8uBt/I5W8W8te8Ix3x/xKXGvIxAaT
         agsFCf7PYmMM6/afA33gK0cdKj2B4AhnKlc1jRZdS+hoOXfiS+EoPf6fIVcwNTJupfgD
         xm1caMDuG7jmHR20FnjiVlyszHya02/hMVGhhDQJAtEmfdUuctBYGkFnbSaAw4E+wCFs
         HrnPvS0vpwBBBbx7kvAIHXu95qjoveTlB/HaDFx5N75aWj/yec9Y5o2JeNJ09D+728wZ
         hj1i196w4l+fzdpuKZNTUlpytW/lyCEDEnwDtbRPYQ1V83IipG4TmxuuscdiQ18jeHfv
         3FNw==
X-Gm-Message-State: APjAAAVVZhldOcjbGF8xe2IgdnBBYVL15DpQuFig69CngymR/fCEiFb7
        vCdxCvqysRXBy7gLoW/T8tsXxpIm2CY=
X-Google-Smtp-Source: APXvYqwzDujzHaoMoYwZOxwsXT6fNP2HAmk0ZtwsJuGhi5NyqnTqD9o0CrRc2N27hDaLAuH8oAA//A==
X-Received: by 2002:a2e:880c:: with SMTP id x12mr8521386ljh.44.1575665034848;
        Fri, 06 Dec 2019 12:43:54 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id k24sm8321057ljj.27.2019.12.06.12.43.53
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 12:43:53 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id k8so9046978ljh.5
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2019 12:43:53 -0800 (PST)
X-Received: by 2002:a05:651c:285:: with SMTP id b5mr9852969ljo.14.1575665033279;
 Fri, 06 Dec 2019 12:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20191128134839.27606-1-georgi.djakov@linaro.org>
In-Reply-To: <20191128134839.27606-1-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 6 Dec 2019 12:43:17 -0800
X-Gmail-Original-Message-ID: <CAE=gft6YoDyOFvYLh-zOmpbNJwfgB0OGugeZKCORz0euMJyS0w@mail.gmail.com>
Message-ID: <CAE=gft6YoDyOFvYLh-zOmpbNJwfgB0OGugeZKCORz0euMJyS0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] interconnect: Add a common standard aggregate function
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        David Dai <daidavid1@codeaurora.org>, masneyb@onstation.org,
        Sibi Sankar <sibis@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 28, 2019 at 5:48 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Currently there is one very standard aggregation method that is used by
> several drivers. Let's add this as a common function, so that drivers
> could just point to it, instead of copy/pasting code.
>
> Suggested-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
