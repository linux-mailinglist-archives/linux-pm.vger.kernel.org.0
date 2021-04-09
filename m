Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C933596B7
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 09:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhDIHtg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 03:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhDIHtf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 03:49:35 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81728C061760
        for <linux-pm@vger.kernel.org>; Fri,  9 Apr 2021 00:49:23 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id x16so5015217iob.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Apr 2021 00:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fs20/90d4KvJp0z8HthQIym10B4OMRw/ctzMO48tMMI=;
        b=eqRBGL+wyyO4H/RvgKFON7TS/zeztjsv32Q4i2aCbGjFDaHfpIl+h4LyU7QB23A6G+
         2R1/jyxhK5IStay2SIK2k04nVwBwkzYuC0NqqswRZPCWmg+wvrO8+G6XOPi+N5s2yOGs
         WY+iOsL8plapw7N3FsSSY6c5yUysmBRgAnSMhxZhbPoNsbDEkj/h0WhLR3U8TPbiSrXk
         Lv+5RpP6Lg04jX76c7+0QEP7vsvLaY7nepORWZpT93UhGsRyxNLAJbHOq19q/tLq9JBk
         ugPs4traUwVLDBHTP1ZHbdfDbBzAp3GKBTEIlGPvR+9QeBdTijcBV9KQEqC/vNzxKksp
         wt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fs20/90d4KvJp0z8HthQIym10B4OMRw/ctzMO48tMMI=;
        b=TDIZr1ZlgWrt6uKOPQZ9f0NlqJWvRRgMq6qpToAuRhIVZF/QE6EhVR11BoNSJyqwc/
         ddxfNewCvIWcoF5VO/c5YKT1DU0XB3hxD92GpSJZo7uryw2EaUK7EOqGS00405i+3OXN
         +6qR46lpBCkpcBolbhTZn4cTsCKfzLUECbzuaIaRw2q+xnAr8sjCGbmP9wqhHQqog953
         cHzEh+q1ATEB+HYDMGLWKyWJk0o3zX7DoADLkRN8oSaN5SWiS2+qe7c8JUL1glZsiVAP
         QsnmYxqHhDnlbUepxi1Jnn0QtSR3qJykL4eUowfZpkgKMgeefrNfuPqnIUmz8E2UeKUO
         DCUA==
X-Gm-Message-State: AOAM530qh1P6PObfc2IVFHk9sV7fcrbpNMMwcwXFdiUtoABop9A8GtwT
        MNNpRF1ayoBNmSeAuWhjRCHrhvsY5QBbdhwhENshJg9apRI=
X-Google-Smtp-Source: ABdhPJwb7I8L/pRldb9Tcv/mc+nkbg2shI3VOYYhWopYvbGqpIYExZQ2bsDNE8pCw7geIxL7Hx4ay51dCvH6XWtTlWc=
X-Received: by 2002:a05:6602:1649:: with SMTP id y9mr10144480iow.209.1617954562834;
 Fri, 09 Apr 2021 00:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210408114223.8471-1-pali@kernel.org>
In-Reply-To: <20210408114223.8471-1-pali@kernel.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Fri, 9 Apr 2021 13:19:11 +0530
Message-ID: <CAKohpomAv8GbEz88HVf8iftWyLC_wNLYgTJMq72MHXO_E1FgRA@mail.gmail.com>
Subject: Re: [RESEND PATCH mvebu v3 00/10] Armada 37xx: Fix cpufreq changing
 base CPU speed to 800 MHz from 1000 MHz
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 8 Apr 2021 at 17:12, Pali Roh=C3=A1r <pali@kernel.org> wrote:

You haven't sent patch 1/10 or something went wrong somewhere.
Please send it in reply to the cover letter, so everything appears connecte=
d.
