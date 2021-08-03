Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA28D3DEEBC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 15:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbhHCNHs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 09:07:48 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:33731 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbhHCNHs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Aug 2021 09:07:48 -0400
Received: by mail-ot1-f48.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so20654401oti.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Aug 2021 06:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ya3uuO3/jRTkl43K2zdZgkezpx6fwubsCQN3ElnBmRo=;
        b=tvQMtbSZym8iVZa6e36YmAVW8+ZWKReRNSGe+vHFVVjewven3ZJjA/T8r7h6AAVfM8
         h2nJso6Q7pEa0YtOp+O2k5wGntTnWD/TrORdZ1/Q+dJaiu4kIWQ4Qq7nfwu+Tvn6D80j
         59tnXwnjLve7Oc9Tp0Zs+coD7QQpwIzKOn6LjMcEi7AJJN5rlut8hkAL5wusgDJKziiA
         8AppVbyTv0NiUTyET4U2BJSmJspHYCXtOtqssR87GkRshS1Gt1HY11Zd6X3pCbCzNpW+
         mIa0TIUIJhAPgfttOhI7bwnWUIso7+h8CuEBfml4RGFsdNXDOfm8TF2dPCjPy2SP98X4
         VqoQ==
X-Gm-Message-State: AOAM531F0o7OdnCdPq8fBtv5/aF1aM8ezwG8GlizWNCFKO51DOyic8Tl
        pEg6OfwZ5rfYYiFykmyR7Dq5apRkpSVhXiqS/GE=
X-Google-Smtp-Source: ABdhPJyW3GL1UQ6AxbUyAc79s76GDZX3BBDwVimPbiBLNai2Zp1l8ZkE69O4z4XVxTRMhlEcMjUIQO5AH0CTbur3B00=
X-Received: by 2002:a05:6830:1f59:: with SMTP id u25mr7519626oth.321.1627996057263;
 Tue, 03 Aug 2021 06:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <0edfdadc-336b-657d-5566-beeb4f4343ac@gmail.com>
In-Reply-To: <0edfdadc-336b-657d-5566-beeb4f4343ac@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Aug 2021 15:07:20 +0200
Message-ID: <CAJZ5v0gps0C2923VqM8876npvhcETsyN+ajAkBKX5kf49J0+Mg@mail.gmail.com>
Subject: Re: Annotate pm_runtime_resume_and_get() as __must_check ?
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jul 31, 2021 at 11:36 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> Seeing an erroneous use of pm_runtime_resume_and_get() in a patch I wonder
> whether we should annotate this function as __must_check. If the caller
> doesn't check the return code he doesn't know whether usage counter was
> bumped or not. Therefore I see a good chance that this results in a usage
> counter imbalance.

Sounds reasonable.  Please send a patch to make that change.
