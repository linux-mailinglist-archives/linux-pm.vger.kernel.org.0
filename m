Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9179D28E6B6
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 20:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389429AbgJNSwa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 14:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389376AbgJNSwa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2020 14:52:30 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CBDC0613D3
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2020 11:52:29 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c21so580212ljj.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2020 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ea58qKonMZ+zepzsR2xAiE+MgtpRXlTME0hK3xVsjQ=;
        b=IFb1zks8vuF3XRjUSmADx7e+bVmtKHTmlQ+xKjmszgDcoFm1cXVR0SQ63/oSB2AKq3
         8/+YORXzioGoI60sXYgwD0VyGc5N51cleBaHgx9qdihjEB2tQYvfF4KLE5Z9LVTyIIn/
         Z7xsEvihhcW1dHlOu63rstkWL/3NxlGNguk5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ea58qKonMZ+zepzsR2xAiE+MgtpRXlTME0hK3xVsjQ=;
        b=YBS8ecT32PYFK1Fm6SzHRNPBip59nKSoHNsWEDClHmDLi3xkGCwMmqbNY+rFaAmqg1
         dQ14JgIgYtvJL/ETkF3ohfL1lVnZEyWou1EWnc0nqyj/93UrcPKjW3dAHUKGaT+eMXuV
         pxjPx1eJEDVFs/kdldUq4aMAv0BCFsi/+Pwv6f6NmWET6KZMsawsejsG0BZkXA6sJVGg
         cliFxkveMGOfXTUASl0YkzYoZJDPRIkipnXq4ONAs4NIPaRbDEMDl6U7Q7TFy2rA0Dj7
         v1I4PCiXwQZTjd8A2+69yi6ZVC4Gc3uDqrdFjgp+r0Y2x9evP382QU1VRDgdihKaErEn
         aJxQ==
X-Gm-Message-State: AOAM530Otcaj7zy35tLsQBZ7lGDBhDuqLJQaYLgte8RSenVuSScByFP+
        +lX9e7XkYPmfReqUWu+oKsFoAYAQrbu1Gw==
X-Google-Smtp-Source: ABdhPJzZa7McD8MeqPndO4PGa8U5+wKxAzIddJWFxk81UB0T9ZvFIUwwcEDZyNJ9yiKyPAG84+P0Vw==
X-Received: by 2002:a2e:9c88:: with SMTP id x8mr22270lji.251.1602701547811;
        Wed, 14 Oct 2020 11:52:27 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 9sm49770lfq.139.2020.10.14.11.52.26
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 11:52:26 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id d24so604881lfa.8
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2020 11:52:26 -0700 (PDT)
X-Received: by 2002:a19:4815:: with SMTP id v21mr210024lfa.603.1602701546151;
 Wed, 14 Oct 2020 11:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0j7XkDh9ddK0BtjWjHqC=xkcyiEEDzTJN=Lykje5-wf3w@mail.gmail.com>
In-Reply-To: <CAJZ5v0j7XkDh9ddK0BtjWjHqC=xkcyiEEDzTJN=Lykje5-wf3w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Oct 2020 11:52:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicsjwDrwRzD5g7YKAnWL+-5LYFr0BqDx873vMcgkS47w@mail.gmail.com>
Message-ID: <CAHk-=wicsjwDrwRzD5g7YKAnWL+-5LYFr0BqDx873vMcgkS47w@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI updates for v5.10-rc1
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 13, 2020 at 10:34 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> ACPI updates for 5.10-rc1.

So these clashed with Andrew's patches that I merged earlier
(particularly commit c01044cc8191: "ACPI: HMAT: refactor
hmat_register_target_device to hmem_register_device").

I think I sorted it out right, but it might be best to double-check my
end result.

               Linus
