Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E825A210AC5
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 14:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgGAMKm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 08:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbgGAMKm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 08:10:42 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFA8C03E979
        for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2020 05:10:41 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so26628745ljn.4
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2020 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0W7BV8cUI7CuBuiHY2QDrSNw3SUVEmFQilJePOeK9o=;
        b=iSLl6gC1LJlLK+whB5oyTs+OtzYClkNiWCwVhfxSa4nWWZE9cgvKbMs0t/oSHF7iif
         zPmUIlXcMvtxLFJp7z6fFiMvN4YJ6rUqMYVlZIaaWTQoxWOm+QMIcyZygSGx8XPiwDiR
         gY7xx5sSSox29urVygQAwHuiedYy8Nm/IOZPe3gvE6DoqVNuSSSCWKaIaDX0E1UeGtlv
         cXHA7O36mWAvOHACXNpQMLAryoNFB+NCZ8eFL0SuWjoGzAh8PH+d+TdXqa7F2DjxpOFN
         DhYOuea6pLyM5G9hE2ygiZH2kw6bz1SRw7/DtQZriZ+mAUU5ileGd3gp8xq6cQ+mfVVu
         krIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0W7BV8cUI7CuBuiHY2QDrSNw3SUVEmFQilJePOeK9o=;
        b=d0j4K1J+FRIcaj8glDZtTNcMbCayQhNU9Dosk3AjlemZU8TRXeX9YKMslKYwICPyIv
         iPTbNjNWL/Ci6muT7l1hRoOIFEnM59h7WoINzmPgn3AWAOlvpkY5mZ48O6si2Tm1dNhf
         PJvHzWEGOTiWHk0dsatDLPDHttuvseHg9Oq23TMFyy9P5m7l8esxMS/9dASNLYQ8UFhh
         10nZWAIl/Ka3mcs4f0lmXqUEPQ0fzDsMHPRhDogBALT7W6qLNb+/Zcx5+ZTZcoi2+Qzw
         LNDE/mRMLuwy0V4mjVhzOCPE3SBxVo5VEGP+hCNfdxY0jEt1Kws0deh9oNJIO13NTYGE
         5qXQ==
X-Gm-Message-State: AOAM532fqsM4QcY3xz5QIOXOynOp9Ro2Vi5Z+N0JswJ60l5vgokhJlvB
        nj5kGiAf2JqKCuw/MKhdCJ4AUNA0KCRkc+9JI4TORg==
X-Google-Smtp-Source: ABdhPJwlyEUVszhEWkGK9ickVjMXKxSq5+Z9Y8911VTJDuTZvkJDrAcgHU7MCWtxM5ciiTIBdB+HA0Lphjo+oygwqUU=
X-Received: by 2002:a2e:8855:: with SMTP id z21mr8588845ljj.325.1593605440227;
 Wed, 01 Jul 2020 05:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
 <20200625144509.17918-3-daniel.lezcano@linaro.org> <CAP245DUMjTQr2vKirZ+FxEYWC=VQ_k+OegxQgXcKDU8ThWuCsQ@mail.gmail.com>
 <0fe6837f-9b44-4578-23f2-3e4932d01122@linaro.org> <CAP245DUG-OsSD-_CucMMQ26HpzjJhn0emfq_go923NsDq6RqOg@mail.gmail.com>
 <c664d247-7f9b-603f-c318-48e534aedfc9@linaro.org>
In-Reply-To: <c664d247-7f9b-603f-c318-48e534aedfc9@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 1 Jul 2020 17:40:28 +0530
Message-ID: <CAP245DV8jT5vj7v6vybw3Eec7wGMXRwFm=Xum5i_n4sMCHHAfg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] thermal: core: Remove old uapi generic netlink
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 1, 2020 at 3:15 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 01/07/2020 11:33, Amit Kucheria wrote:
> > On Wed, Jul 1, 2020 at 2:56 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 30/06/2020 13:47, Amit Kucheria wrote:
> >>> On Thu, Jun 25, 2020 at 8:15 PM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>

> >>>>  /* Adding event notification support elements */
> >>>>  #define THERMAL_GENL_FAMILY_NAME                "thermal_event"
> >>>> -#define THERMAL_GENL_VERSION                    0x01
> >>>> +#define THERMAL_GENL_VERSION                    0x02
> >>>
> >>> This hunk should be removed since you set version back to 1 in the
> >>> next patch and we don't actually intend to bump the version yet.
> >>
> >> Well, I've been very strict here for git-bisecting.
> >>
> >> I move to V2 because of the removal, but when adding the new genetlink
> >> code, the family name changed, so we returned back to the V1 as it is a
> >> new genetlink thermal brand.
> >
> > I don't understand the move to v2 for an empty skeleton UAPI. For the
> > purposes of bisection, couldn't you just remove all the v1 UAPI (w/o
> > bumping to v2) and then add a new UAPI in the next patch?
> >
> >> The name is change because it is no longer event based but also sampling
> >> and commands.
> >
> > In this case, just to avoid any confusion, the new UAPI could be v2
> > making the transition clear in case of bisection.
> >
> > I'm afraid the v1->v2->v1 is a bit more confusing.
>
> Let me elaborate a bit:
>
> Why there is this patch ?
> - By removing this code first, the next patch will just contain
> additions, I thought it would be clearer
>
> Why increase the version here ?
> - Code must continue to compile and as the 'thermal_event' family is now
> different from V1, the version is changed
>
> Why the version goes to V1 in the next patch ?
> - The family name is changed as it is not doing event only, so it is a
> new netlink thermal protocol and we begin at V1
>
> So the main reason of this patch is to be very strict in the iteration
> changes. May be it is too much, in this case I can merge this patch with
> 4/5, the old netlink protocol removal will be lost in the addition of
> the new protocol. I'm fine with that if you think it is simpler.

Considering that there are no users of v1 currently, it feels a bit
over engineered, IMHO.

Also, the new UAPI doesn't need to begin at v1. Just having it start
at v2 will avoid this confusion, no?
