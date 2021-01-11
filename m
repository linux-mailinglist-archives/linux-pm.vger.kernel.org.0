Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F022F12AF
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 13:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbhAKM6e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 07:58:34 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:46946 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbhAKM6d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 07:58:33 -0500
Received: by mail-ot1-f51.google.com with SMTP id w3so16716527otp.13;
        Mon, 11 Jan 2021 04:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNxcPaXROOnGFH5/cTAiZ6cTgD30b0GB2QUrGXi9b0U=;
        b=sj21mNDfiITnLfd/oIaqrDGugO0lNfBlv4/Sn9g8VEPy7n/7Ik4LQIl19zSyp7AYvV
         XHwsGO/9SKKNNHInQe6Ww3WBPGdDOklu+uKuJqXrbFzz8JJZb0L7wpLlQH6jEf6gwzvI
         /V2r/XgrPVSdpsXFnXpyxanIIsr2WtCJZP3XsY5Ym44x5U19m4ql2fttDrHMsqpM/4Dq
         KOXj9dc1LvUbTJnRThdCQl+RtHYbdi6s3I1AMC9WHIf3DcqWm5EyWME2eaua9Dsy92Ru
         8rJUBUoSLPENBXxJDOXYyJ/2va+ODhsjsS0RsC/a9bR2B18/P9ruLLH6z+cHu8DIKaHF
         uEmw==
X-Gm-Message-State: AOAM53273AsT1lAJoI5YE1yGakSJ6y5WlWGbZ3vgOkPjUMb6rWjrPz+J
        x8FyXHTZQayjy9SmknPum0kNyMRe0pObzwPj/ms=
X-Google-Smtp-Source: ABdhPJxWCmmLDt02+kJsbuUfy6CX/euQYDvLo/F4pWiHPDig0VytwEHUXswqPacP/qzvd+ip0++GGLPybgbf3323FQ0=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr10618079ota.260.1610369872787;
 Mon, 11 Jan 2021 04:57:52 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2101102010200.25762@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2101102010200.25762@eggly.anvils>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Jan 2021 13:57:41 +0100
Message-ID: <CAJZ5v0gUQApODPUuHkfmHUw30XhX3U-5zYDu5JrgehzVrtyJQw@mail.gmail.com>
Subject: Re: 5.11-rc device reordering breaks ThinkPad rmi4 suspend
To:     Hugh Dickins <hughd@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Hugh,

Thanks for the report!

On Mon, Jan 11, 2021 at 5:44 AM Hugh Dickins <hughd@google.com> wrote:
>
> Hi Rafael,
>
> Synaptics RMI4 SMBus touchpad on ThinkPad X1 Carbon (5th generation)
> fails to suspend when running 5.11-rc kernels: bisected to
> 5b6164d3465f ("driver core: Reorder devices on successful probe"),
> and reverting that fixes it.  dmesg.xz attached, but go ahead and ask
> me to switch on a debug option to extract further info if that may help.

Does the driver abort the suspend transition by returning an error or
does something else happen?
