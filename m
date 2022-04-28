Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517D8513BD4
	for <lists+linux-pm@lfdr.de>; Thu, 28 Apr 2022 20:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351269AbiD1Sxl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Apr 2022 14:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345542AbiD1Sxl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2022 14:53:41 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF51205CD
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 11:50:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w19so10199650lfu.11
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 11:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/3kak4px7jr3LInyUqNpuxAJYL7n0yOLiasgLA10vts=;
        b=I6KWsFSB6vz32X8DnsS8yLCJaLOJTYxiA2Puz8Fx6icNuiQsPvy/oIhqF0ORPdhQOt
         Th9ZVpd9sHvAarrSdfHK/SpuW/5HWf1PYD+3siS5jtp1bykTFknkwTDU1LO62qH3wLG6
         907IvJnTw3shXZpDWyBzOOW5IM+QU51o4eZTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/3kak4px7jr3LInyUqNpuxAJYL7n0yOLiasgLA10vts=;
        b=cPCI0rzxjiGS4WD8KEGZqWtDZkLZ4ySKh03bdg4Murr4fizrLGYcif8PyLWgH5pLiY
         rpCWTCqr9/HP1khFmo0EAj6O7zoHE8nUdcqw+DzyptSIwY8qShP1nG0PkmcT2Zo+MEqq
         QFOka6rZajgDltGfe+4ZzCH7PbJeiySTirYhzZljGBq2szb0sHOefCbPmZATE8HTF252
         EIMAn2dF17llxwbmciqh0Oq6wLRUpsWTsCZx+hQyqOS0BPqoOt+EFzik/fux+Jqj2qIf
         t7GcbpqVIwa18gN4pOGE5k3oeHMsp+eOWHIVFeU/wV9f8ix0y4skP66nYpe8z2po1lUx
         oHaw==
X-Gm-Message-State: AOAM532SEKlTA+L2usgqjLjrmh6pUd+0QiyjqxROV1BJnQ/fzmj0OE3E
        cpYovyABwY0R0Drv5K782XZJb1r8CfRZIV8hUB8=
X-Google-Smtp-Source: ABdhPJyoHVVacxgUKdBK9m5GXrq/OgFM/x8w0te3U++S42o/fKZylKIVVONJ8axt7a/8cAFh4+TPSw==
X-Received: by 2002:ac2:4202:0:b0:444:14bf:86dc with SMTP id y2-20020ac24202000000b0044414bf86dcmr25211313lfh.126.1651171821018;
        Thu, 28 Apr 2022 11:50:21 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id u2-20020a196002000000b0047221dc6c3dsm68319lfb.105.2022.04.28.11.50.19
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 11:50:20 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id l19so7875986ljb.7
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 11:50:19 -0700 (PDT)
X-Received: by 2002:a2e:8245:0:b0:24b:48b1:a1ab with SMTP id
 j5-20020a2e8245000000b0024b48b1a1abmr22123546ljh.152.1651171819543; Thu, 28
 Apr 2022 11:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0hHYRsWkRsJj+_Wa=jTS5cHasajYeh14yxEDvxu7gWWRQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hHYRsWkRsJj+_Wa=jTS5cHasajYeh14yxEDvxu7gWWRQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Apr 2022 11:50:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wit9xfwAf=z6YqkZerH28qFYeTnhr3GtBqCYBnsTsSYXw@mail.gmail.com>
Message-ID: <CAHk-=wit9xfwAf=z6YqkZerH28qFYeTnhr3GtBqCYBnsTsSYXw@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.18-rc5
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 28, 2022 at 8:30 AM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
>
>  - Make the ACPI processor driver avoid falling back to C3 type of
>    C-states when C3 cannot be requested (Ville Syrj=C3=A4l=C3=A4).

Hmm.

Doesn't this avoid C3 for _everybody_ rather than some conditional
"when C3 cannot be requested"?

Of course, it looks like the 'has_lpi' state still potentially allows
C3 even for busmastering sleeps. Maybe that is what you meant.

             Linus
