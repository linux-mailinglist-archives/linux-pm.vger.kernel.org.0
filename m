Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933AC250FEF
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 05:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgHYDXc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 23:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbgHYDXa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 23:23:30 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9293C061755
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 20:23:29 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so12076171ljg.13
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 20:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwIDiEHCgFI/z0l9AbVx2Rus6kHSaCq0t8VGnTYdsUg=;
        b=AP39QCkNHRTcbqx+ihKM5zWiPHxMHcuqzIowLMsHSF/RASXPkPnRzIdPyED03bfHDC
         LI3F5BPC5wAsogVm2imEiJ+A+91OaT9KuD3IHhTTgHaccrekJfROD011iHpxBNG0liOZ
         4IZdlSJZu+4hI60EzW8jat/PIPnyu/NDg7Y8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwIDiEHCgFI/z0l9AbVx2Rus6kHSaCq0t8VGnTYdsUg=;
        b=FQnwTQwe3vousimNQ3jn4ApRH1vA2Wmb+Y/L45nkfrTgsDRdKeB9TTdvXSMzJ42G9M
         brKAOBToME+MoJDrEfpkp0tcmv4RfWkZWlVeBmrNW34aG/I9Tn+8cSz0ZWp8/6LC3aA7
         1kkoJtU4M3iusxUnj6AtlfeSkwkzvKJSaLLJ3RJ9If/bMuSVHIJjXcyUM3NrM4w30bqR
         1kCpKwn7wkaXzQQkttORuI2lDw0k7Ng5vU0H+L+l0vxXTdH12Ku/ekVYOgQLgjP9YyHx
         db32LA9IGXsjFJlMsXZRanWunOip6Pinh+tGZ0A9IQnBQHBM90rkhRu6+smw26CrRE+X
         Ba3g==
X-Gm-Message-State: AOAM533jbd5VzHbeP1rLT7dlwB9T1IaJGkSxxSBQ+hKrFEsv7tyIkQOD
        V1VBQ578ReTyNs81NRNYDUDYSosamv8Peg==
X-Google-Smtp-Source: ABdhPJxU1VPv7AQEIitqToVaSCs9O1QneJaotHF1arwepRLaZVbYG1qIm4M863///TLcPADUnsr1ow==
X-Received: by 2002:a2e:1418:: with SMTP id u24mr3775256ljd.120.1598325807814;
        Mon, 24 Aug 2020 20:23:27 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 206sm1913298lfk.60.2020.08.24.20.23.26
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 20:23:27 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id t23so12101450ljc.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 20:23:26 -0700 (PDT)
X-Received: by 2002:a2e:80d8:: with SMTP id r24mr3731295ljg.305.1598325806305;
 Mon, 24 Aug 2020 20:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200729104933.1.If8e80e4c0c7ddf99056f6e726e59505ed4e127f3@changeid>
In-Reply-To: <20200729104933.1.If8e80e4c0c7ddf99056f6e726e59505ed4e127f3@changeid>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 24 Aug 2020 20:22:50 -0700
X-Gmail-Original-Message-ID: <CAE=gft4zqA8mwt5UYBrBYNUzF4cQdg7m=Zv48ffe1Pbm1HXv4Q@mail.gmail.com>
Message-ID: <CAE=gft4zqA8mwt5UYBrBYNUzF4cQdg7m=Zv48ffe1Pbm1HXv4Q@mail.gmail.com>
Subject: Re: [PATCH] interconnect: Show bandwidth for disabled paths as zero
 in debugfs
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 29, 2020 at 10:50 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> For disabled paths the 'interconnect_summary' in debugfs currently shows
> the orginally requested bandwidths. This is confusing, since the bandwidth
> requests aren't active. Instead show the bandwidths for disabled
> paths/requests as zero.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Looks good to me. I briefly mulled over the idea of showing the
disabled flag as a separate column, but I can't really think of how
that would be useful.

Reviewed-by: Evan Green <evgreen@chromium.org>
