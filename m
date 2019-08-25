Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 459D99C607
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2019 22:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfHYUAv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Aug 2019 16:00:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45802 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfHYUAv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Aug 2019 16:00:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id m24so13284410otp.12;
        Sun, 25 Aug 2019 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BnqxOLA8r90y97Lp5feVAq8KO0vU53UAi87Q9EqgQA=;
        b=AsbeQfzzSIJo+vyXHZwV6YfVP6kZ4Kohm8HBci2wkuTRoFc8tq+Yh3uXGgGe3Bc6N/
         iJBherhwguu9LRd+ii94Iv6OG6fOSiE4V8msy7Wt23zzpNw5A3khVtR9FioVtJMNg3+j
         bX2/S+Y9InIe1yICt5ARAoiTDiyiQLFIPSLJeBNfF5LeRMMvoZTjT5FdT0sgFhxdI0eZ
         zyGXLU9ZNMWDuZ+MuYAp8IYKfyIrCOHGkwf6k4VpV3WPAxyN+GcdSsGxAv1w6SvOB8MK
         btkLfJ75gpD+uABJUlo9Ma0PF2vVEWTfehO8O0TcB7QkRI03fAQO45tqsgEdcYrNFVTH
         p96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BnqxOLA8r90y97Lp5feVAq8KO0vU53UAi87Q9EqgQA=;
        b=Ng9ww7BEtrQ05dliay+B/spuskCjN4hn2R1TC7JpjWx9b11E0wn0uHGVna29o85EdF
         sxTOfDWXIrbx/R9FnYdXvGgFOQfJ8eg9aXYD1pxxNa/bHGQo5nfdsonCdN8G3sSli/li
         QGMVx6g7mldySJl5eoANJmHNBIZwtgEEdBCstOq/9ReXJe8kSOmbv2PmJxm6PJNgp+5W
         R/0v1PYvgi70X5jrCmXGF8BFa3xiYxJjuczkaYBD2YcFHH8+vxC4/Oo6ySak2L6EPoro
         T5PmvoDpkuwC48bEjGEaURRLpbzGH3u+6MRCVkXg095XkqtKtrrBQs22DApzdmTOrbRG
         CYcQ==
X-Gm-Message-State: APjAAAVAOEb6bDY2Qxdz+rgragba8dJthV/8dz5C51H54QsR55MmVSJA
        /drG6gW33BC4Kx0+/JRTgxNkUbfNQadY0W60Lu9RwxDV
X-Google-Smtp-Source: APXvYqyqDo8QI0aN4J75YWtE2lRXHhmIJArBPeiCvJHlr70ZxYAwAzvjeKsx3hcpNPj91nj2cogn9EDf0qfX7vzAkP0=
X-Received: by 2002:a9d:6c0e:: with SMTP id f14mr8712052otq.6.1566763250104;
 Sun, 25 Aug 2019 13:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190823090418.17148-1-narmstrong@baylibre.com> <20190823090418.17148-5-narmstrong@baylibre.com>
In-Reply-To: <20190823090418.17148-5-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 25 Aug 2019 22:00:39 +0200
Message-ID: <CAFBinCBypL5D0Rs09V5xZBrV+Spnz-9H8WnFq+0KoLZbtEprfg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm64: dts: meson-sm1-sei610: add HDMI display support
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
> Add the HDMI support nodes for the Amlogic SM1 Based SEI610 Board.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
this looks sane so feel free to add my:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
