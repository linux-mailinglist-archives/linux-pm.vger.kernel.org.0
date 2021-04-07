Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337F0357317
	for <lists+linux-pm@lfdr.de>; Wed,  7 Apr 2021 19:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbhDGRZC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Apr 2021 13:25:02 -0400
Received: from mail-oo1-f53.google.com ([209.85.161.53]:42782 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhDGRZC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Apr 2021 13:25:02 -0400
Received: by mail-oo1-f53.google.com with SMTP id h3-20020a4ae8c30000b02901b68b39e2d3so4713771ooe.9;
        Wed, 07 Apr 2021 10:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gwq7QKILHZwZMl3lAkpHT2dUFN4Ic/8XItG6AMkXBig=;
        b=UDOHBrGqLtmupoO+qC4cAmVD5EiL++7al7wRFfpjE8u8XEnXm7VkTn1UuA1DSKDpnU
         4+s5Vy4tgCRarAvQosAHPZ5vmumbkVdBSG8DG6SroYcOF77yRsjKACLqqVVRDycrwTRR
         4OmCq5tGzQ3SjYUtd6+5cTYkRzech55M1/mutMBP1DAgaPI+J7Ptoheo7N2vtd9ZwkGx
         4Cn6EUdBX18E7QYWYSk6yeUblCRji9V3fbJoQqTa5zY9mGCfgmOqcSL3OprXx1tAs0G8
         AzFi+9E5YzdvfoUVNe/CNA0tKZUatwAbk3PyFT2rXmfenRGBR0xJky4dVHQ+hyATVP6c
         8ToQ==
X-Gm-Message-State: AOAM531HEcsgm2d4dozHnqATaUVIGr14lYum+TrnXWUN0w1cK+/cHfBn
        H1grISOb6ATmuHRRbkxF6h3EABy77BeIMJXj++zT4XDf
X-Google-Smtp-Source: ABdhPJx3AeN5QPh0GiZbfCMbGItUQ9h4R9SVloYUH4SkJOcnreLOUZrn3q0pLCLGee21BzVGrCc9rKcbCHy+/hn1Smk=
X-Received: by 2002:a4a:41cb:: with SMTP id x194mr3910804ooa.1.1617816290754;
 Wed, 07 Apr 2021 10:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <2764850.e9J7NaK4W3@kreacher>
In-Reply-To: <2764850.e9J7NaK4W3@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Apr 2021 19:24:39 +0200
Message-ID: <CAJZ5v0iMpOtNdnAvx3fRP-wNz4OBG9ZyDXVG0KnHDdGz2U4ipA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] cpuidle: Take possible negative "sleep length"
 values into account
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 29, 2021 at 8:38 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi All,
>
> As follows from the discussion triggered by the patch at
>
> https://lore.kernel.org/lkml/20210311123708.23501-2-frederic@kernel.org/
>
> the cpuidle governors using tick_nohz_get_sleep_length() assume it to always
> return positive values which is not correct in general.
>
> To address this issues, first document the fact that negative values can
> be returned by tick_nohz_get_sleep_length() (patch [1/5]).  Then, in
> preparation for more substantial changes, change the data type of two
> fields in struct cpuidle_state to s64 so they can be used in computations
> involving negative numbers safely (patch [2/5]).
>
> Next, adjust the teo governor a bit so that negative "sleep length" values
> are counted like zero by it (patch [3/5]) and modify it so as to avoid
> mishandling negative "sleep length" values (patch [4/5]).
>
> Finally, make the menu governor take negative "sleep length" values into
> account properly (patch [5/5]).
>
> Please see the changelogs of the patches for details.

Given no objections or concerns regarding this lot, let me queue it up.

Thanks!
