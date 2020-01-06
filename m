Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8018A131AA3
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 22:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgAFVpX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 16:45:23 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44109 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgAFVpV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 16:45:21 -0500
Received: by mail-lf1-f68.google.com with SMTP id v201so37335809lfa.11
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2020 13:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZjQqjrgkh7UnNQJ1G1FfRv0Qnrcc+UBzR3ffHuWmJLo=;
        b=T0Cp49iNhBPtry9RRB9H+4/H9Cnci8jBAdb1agffxxbBZu6dSlRujUOlO6q/7+po8t
         NukgfrM75WAPZX1AMqK16k1GbqFYWxukeGtta3bKoaYbWTZfheDRoEVQpqgjbqrwy3vD
         qu9KIfq92QbOMNPQ6wY4GF+gKyepaOsnp5LmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZjQqjrgkh7UnNQJ1G1FfRv0Qnrcc+UBzR3ffHuWmJLo=;
        b=c7ScjwTnlucnEwV6wD5Bxq5bhOpnkZvNe7objlk9+ho6zJvMP5sldd5qdJy96TxXSA
         zMGPLr+JD2xXQVC24YNJ0SCbBz4WZ4qKZ3aj/jPrCHtVzvQAaXRX0+Vhk6jUL98tQuJO
         X1qtL1gSoFndEKix+XrF+cITk+laiES2LJ2Cwnv/uWZaADW8TP8pYpL8h2KDPjbD4nQu
         fBIFM6BaT1wd2q5eJWwiiGO1zEQ5MdvR9ZPpduJpMLDsgfbqj2/S/qLT/6oNfrRT6AFZ
         p3pti+PDZjL0z7sZYE+nxRP6qNfhjBN6/6LRDJKWaE39jkvkAqeHi4WxdaXoG2Hbgk10
         TYXA==
X-Gm-Message-State: APjAAAXXn7vlFmTbAx0GcgkSYeEFqtc67Oz3kbm8wcL1q76on1ph1AC+
        EsieAbq6841Kw6/VifhWxl30uf2cuks=
X-Google-Smtp-Source: APXvYqyNRbWJBCKQs0mRGMXSY3HNlVR0bLylR0XZpoFavUBVuJSaj/hWs4HKBuQIJ71Mv2rDlidAkQ==
X-Received: by 2002:a19:2d0d:: with SMTP id k13mr56397645lfj.12.1578347119004;
        Mon, 06 Jan 2020 13:45:19 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id z13sm2701560lfi.69.2020.01.06.13.45.17
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 13:45:18 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id m26so50031286ljc.13
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2020 13:45:17 -0800 (PST)
X-Received: by 2002:a2e:9e4c:: with SMTP id g12mr60097737ljk.15.1578347117398;
 Mon, 06 Jan 2020 13:45:17 -0800 (PST)
MIME-Version: 1.0
References: <20200106172746.19803-1-georgi.djakov@linaro.org>
In-Reply-To: <20200106172746.19803-1-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 6 Jan 2020 13:44:41 -0800
X-Gmail-Original-Message-ID: <CAE=gft60FwXEVxS5DohqBaQTFOfCZ7co3b3KEQyongGNB==E0Q@mail.gmail.com>
Message-ID: <CAE=gft60FwXEVxS5DohqBaQTFOfCZ7co3b3KEQyongGNB==E0Q@mail.gmail.com>
Subject: Re: [PATCH v2] interconnect: Check for valid path in icc_set_bw()
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 6, 2020 at 9:27 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Use IS_ERR() to ensure that the path passed to icc_set_bw() is valid.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
