Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3F249C603
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2019 22:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfHYUAJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Aug 2019 16:00:09 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39219 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfHYUAI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Aug 2019 16:00:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id b1so13314539otp.6;
        Sun, 25 Aug 2019 13:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXY+vp9jRGpj9AwVjvaZbbtqnQMg4LrCQrKGAkuzItM=;
        b=F2OO1oz7p1xplg6LJMZYwvRm0fnVwDnp6BRBhYp0l8A0qZjst2X8KsuaKIMIkDoZEQ
         pCHsZ9rC94kNLoL6YSH6/UWkUw1spBjrUwNIBJvzjRCuxSBZse74rLt6T3Jx9ngLcKtc
         H/yi/sDUOMb3elM1YnWXXuYV8esWMdW4hvGp2i90GxJGo1wxktZINaHPZiQcJVgnRdVV
         LL9oSNIQr/Vg0fd15sq9o34SjRfS6hwtW68De9wkPWyKiUewd5+ODOJOcUwRzwb+LhBx
         +r6b7s9vRhtciZ4c5Zu6Uj4vwu4f1icD7pmiOm8XkYCAHbnwDvMuzXYE7u8lXOrfH8qp
         bxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXY+vp9jRGpj9AwVjvaZbbtqnQMg4LrCQrKGAkuzItM=;
        b=SfNvXW+0J2H7r+hktDLz2DS4cIQDpPlZ7Rgvvk6dPc7GZdV0bdNBPuboYjUlyrLiJr
         Dc/sRfebRPHrKQIEExatRA8BJdND1KCJRuVetH7ZAUtbm5FFlDS79cL47V5uN6Wn8mbJ
         KSCHJuP38DQ+NTxn4pcYUG5fPU+vegaFdDpAA66a5VprdPSk7v8s8a6VrbEZpU7xzWX7
         rJWJ9X/2k0nfdD7y6pSC95u0u7uCaE20TQeOMnX8+5U9uSKGza5Xdkcd7/fuwB9sLElY
         LfNCphNQf0fWWgss2prIznGFu/07pcpYqHt5Oi8pQGogIunjTeFIW5CqJ6tgqafLYuUS
         cmgw==
X-Gm-Message-State: APjAAAWuA6pSghE0jua2JgGOuvAVQQADSFbFD8flpcgLqazp053IwXEs
        5YMb/8Fuf7vtuzwoEh+AlU0yNr8pOBNlbsfhIcAiN2gA
X-Google-Smtp-Source: APXvYqyZu4IJ7I+DpLeCK6W/EgEKtsIl2fZBrWMoOYcz2co8fxVnv4eQJJUV/XDH381rnV0JfTwdjzjeHaJs5fJoXAg=
X-Received: by 2002:a9d:7b44:: with SMTP id f4mr3819368oto.42.1566763207717;
 Sun, 25 Aug 2019 13:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190823090418.17148-1-narmstrong@baylibre.com> <20190823090418.17148-6-narmstrong@baylibre.com>
In-Reply-To: <20190823090418.17148-6-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 25 Aug 2019 21:59:56 +0200
Message-ID: <CAFBinCDjO2sWcE8hmPfn1vsar52yeeTVAZaYJ6vR3rXaVJQQPg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: meson-sm1-sei610: add USB support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, ulf.hansson@linaro.org,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 23, 2019 at 11:06 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the USB properties for the Amlogic SM1 Based SEI610 Board in order to
> support the USB DRD Type-C port and the USB3 Type A port.
>
> The USB DRD Type-C controller uses the ID signal to toggle the USB role
> between the DWC3 Host controller and the DWC2 Device controller.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
(based on the patch description as I don't have the schematics for this board)
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
