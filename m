Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D867CFDC7
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2019 17:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfJHPjb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Oct 2019 11:39:31 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:39943 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfJHPja (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Oct 2019 11:39:30 -0400
Received: by mail-ot1-f43.google.com with SMTP id y39so14399650ota.7
        for <linux-pm@vger.kernel.org>; Tue, 08 Oct 2019 08:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwkO+3ktpSvNGA1jiblIY+xHLOPGL+kL6G6Dfov9F2M=;
        b=gA7nqIi0TusjdoizgldqNgJT0MZRvjCx5HTwu/3C9WgxjutoZ9yfq9pjsc8FSbxC+i
         ztHvU/U5pzrKakYLe7oh5ZRUfM2LgTaZwHeFeiIGz0D6KYBzT4N0YdK8GGE76ImFx43e
         GpUatZcpq9f5LloQE/pM1a+sM3D+QM86f5/PvG4M+tdp+L8sBtIUvn8v9M+qWr5G8R50
         36S9eF9VceduIhruF7P6fISIjI8zrTZK9mTi2Ru/OzCJRN7MsNGHMc1F3RgMUZh2ekWG
         93nBi2XHmYdBuApmfG+feqjaN5Hv0UeW+58hCEdFnQqhvp+UE6E8ZWzW112eaYXqBjl/
         S7NQ==
X-Gm-Message-State: APjAAAV7lFVU/cgJWSrsOwA2g79lLs8SzcGZXE6XYYJzYG5EKzSPHI+l
        dIJZgEetwwmAXStCYxoUhWDxMCy0gz+iJSLrrQk=
X-Google-Smtp-Source: APXvYqzpvZHDGOhIXdNjqdlCll66C1E3HQ5LKVA5WaERo79HpH2qX1Y4uqZRdd2FZ8dQ5Wv/BUAszHDPSZFFJt10zeM=
X-Received: by 2002:a05:6830:1504:: with SMTP id k4mr12785579otp.262.1570549169578;
 Tue, 08 Oct 2019 08:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAA25o9T6C4VCVbqzS0hJgmvpJb6h+htFpH3OUY30E2VtuG8fxQ@mail.gmail.com>
 <56319808-87dc-76ed-c1e0-9f60108e94a6@arm.com> <CAA25o9TpBm+LNwVccTaUng4vQ1Q9_Wz2QftGho7DG_+26CCYoA@mail.gmail.com>
In-Reply-To: <CAA25o9TpBm+LNwVccTaUng4vQ1Q9_Wz2QftGho7DG_+26CCYoA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Oct 2019 17:39:18 +0200
Message-ID: <CAJZ5v0jCb5jLVQ2Oj0bSNf987apxi7SHx4duX9eALMD6QQXB+w@mail.gmail.com>
Subject: Re: hibernation memory usage
To:     Luigi Semenzato <semenzato@google.com>
Cc:     James Morse <james.morse@arm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Bas Nowaira <bassem@google.com>, Geoff Pike <gpike@google.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 8, 2019 at 5:26 PM Luigi Semenzato <semenzato@google.com> wrote:
>
> Thank you for your reply!
>
> I understand the need for saving all state, not just process/task
> state.  But for many of the systems that could benefit from
> hibernation, the majority of RAM is taken by user processes (I am
> thinking laptops).  It should be possible to copy their anonymous
> pages to disk more or less directly, without making an extra copy like
> it's done for all other pages.  I am not sure what happens with kernel
> tasks, but they don't have anonymous pages (that I know).
>
> I am curious to know how/if hibernation is currently used in practice.
> It doesn't seem practical to require that user processes take less
> than 50% of RAM at all times.  There may be special cases in which the
> restriction can be achieved by terminating non-essential processes
> before hibernating, but I don't know of any.
>
> I would also like to know how much work it might take to avoid the
> extra copy of the anonymous pages of frozen processes.

Whatever doesn't fit into 50% of RAM needs to be swapped out before
hibernation.  The efficiency of that depends on the swap handling code
and the underlying hardware.  If that is efficient enough overall,
trying to avoid it altogether isn't going to make much of a
difference.
