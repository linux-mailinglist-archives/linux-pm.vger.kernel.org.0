Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A0A449EC3
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 23:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbhKHWxX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 17:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240791AbhKHWxV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 17:53:21 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEB1C061570
        for <linux-pm@vger.kernel.org>; Mon,  8 Nov 2021 14:50:35 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id bk14so7264963oib.7
        for <linux-pm@vger.kernel.org>; Mon, 08 Nov 2021 14:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wzbq21jEiIL9z0Wvbk1oD4Zrjwz1khIGy04ukq+RNE0=;
        b=LkMa1EGwAQN/h8udna9hkZM29+jtW+AO391XIUaMTfWdEPLdBYFiWhUJbRpxh4HyHx
         qawH+bHhU6bU4VYQ0siW/tdLT6WukFPDIDvz6of9xh++fE97hB1UQxbhkvEVLexjGrl0
         7mV7Vc6d+NIxgcLaYxOcpQ1o6ID6K2p4KebEbaQjrEAG7jSrQJdGwT61T/MFpJS6qjzk
         5PdyAOQBFvGUy31/7x/XwvQy8D6B7fqQ8PMJDR19rfEmkEAzmHMsi/bMHc+Z0O/UcOzb
         9N0NXkZ0UIaMwwcHeoVnIj69NbK2Oro5BNY1u+aaZrDtduNePusEIJ2k8Cb5gBa9Rpr7
         Im7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wzbq21jEiIL9z0Wvbk1oD4Zrjwz1khIGy04ukq+RNE0=;
        b=0LSd2Dob4Sseaj2ft80/oLfMyazjyb9iDDd2vyQ4pfNjuF2RQUvgynK+1UcffAgOO7
         dRZu1NDIgGjTibV+bdhio+Q5oVenCGUqdVZLTB+bU/1aSW8B49iqK+uZ5vq/vvCVYKY9
         Fko+BVlhbipobdXU2HJO7dtRB5wwYX4ghTMUt013CPCOFBNHPAfisjF+w6oCFsHr55Uv
         XjrPQd6/ZhSmSW5XVOvWO+iWvhey+n36VPO1Ti4icTM3xwsOI3avZnRJiQpcEudXk4Nz
         FC+Vz8kCRMJawToykVA5XR+okDAtPL/Ahuzw4t3DGogOr9h+MSiauwUqoRwzim9M4yRQ
         ySPw==
X-Gm-Message-State: AOAM531jbRzsNC2ZQYKANtaoK2UAgYS9W7vYhwOXkQtCA80M1+B4CJ7t
        DMGkMPNVGlwbs0BCSDO+tuLCywtc5baXYSao6/ZgJw==
X-Google-Smtp-Source: ABdhPJzX+5/Rnl1oOvixAqKR6SWlmI4XoiwBjzFG2CXMvXen3rvuo5xLCBFX6QSddmtAL8fulSjDTkZP+/Fz1v4NMGQ=
X-Received: by 2002:a54:4791:: with SMTP id o17mr1759209oic.114.1636411834440;
 Mon, 08 Nov 2021 14:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20211105003026.970184-1-linus.walleij@linaro.org> <d296ee8c-f6f0-aa42-e261-ed631f598fd0@infradead.org>
In-Reply-To: <d296ee8c-f6f0-aa42-e261-ed631f598fd0@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Nov 2021 23:50:23 +0100
Message-ID: <CACRpkdb0BT43Zm5=OgKFTgYeabNy7B0oRFO9aOJCy4Pbz1TJtQ@mail.gmail.com>
Subject: Re: [PATCH] power: supply: core: Add kerneldoc to battery struct
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Randy,

thanks for your review, I incorporated all of them, but I have one
question:

On Fri, Nov 5, 2021 at 3:20 AM Randy Dunlap <rdunlap@infradead.org> wrote:

> > + * @ocv_temp: array indicating the open circuit voltage (OCV) capacity
> > + *   temperature indices. This is an array of temperatures in degrees celsius
>
>                                                             preferably    Celsius

I understand spelling Celsius with big C (he was even Swedish, I should know...)
but what is "preferably" here?

If the idea is to reuse these properties between different chargers and
batteries we should rather state that this has to be Celsius or
we will have trouble.

Since no driver is using this yet I think it is fine to mandate Celsius?

Or am I misunderstanding the comment?

Yours,
Linus Walleij
