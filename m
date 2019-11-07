Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF090F3AD2
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 22:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfKGV4n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 16:56:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38191 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfKGV4n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 16:56:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id w8so2540653plq.5
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2019 13:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=mWI9stxDpq8HJvqv8MCISb1ecAdUqoG0T1yUS3u0IrA=;
        b=s6jn1u0Kn+ufylzuMEdtOyFKuLD2exS9830kqrL8skohXscPiciZr4QIvU52nusuFN
         G9bfAFb9pUxCEqp8O8G/9FJKau0y9+bkclzBOZszFINzEU2pv9Ns8AuuV9vpUFeRef+F
         XSd5IwXG0je9F4DYdkMnLZCED0qQL4KixehnjwND0nCgFfmp/ktaFi+vucg9MQ/T7GCS
         yuDOiZRp112qlfDiuPPorFYOLFRl+52BB1zNcme6CvVv61B4V8YATnFoh2f2/7P9VT40
         j0iv692KZCbB/u1a4LBT0YsfXbP85XkviJkxXqM08bstxkgv8uPJ1adoKbx7/fPGpR0T
         jLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=mWI9stxDpq8HJvqv8MCISb1ecAdUqoG0T1yUS3u0IrA=;
        b=ioWf1U7+WVzWqOGjczgjWwTW8QTpLyg0URmYXUtGEDh4ERT+32BJfk7yMaI8C5HPTk
         v/8QfYFyBniVBBgDoMYlRAgoCpe0NS6XnPsIIYaOznqWpqjxx3pkqM6slhiPhhbGi8rP
         ZW/YsuwEyJWyFpLu8UAjhgpMwTrZOt4k9ZEYylLDErQL2JqwNW9pWkKJxoo/1m//uGIa
         oYUEEno0eMEAQJzH51bdANq2giq6mZ5T/xT96eSvAXfUXCslhTx73Tj6rowQXi2qYiiU
         TXMIPmiH0gNd8vgdHyIl+swe+FcFs0dxEsgOlPnrtPSrhLn7zluGl58eipEtNBTfN2Ki
         NaFQ==
X-Gm-Message-State: APjAAAUVJuEe7d8TjaMijdQYmnJHd3esvnY5OCXkP7qJ0wUJ7QW3vvPo
        51SmJLhbfuy1bS3fNHEU6QT9iQ==
X-Google-Smtp-Source: APXvYqypGBDtT9XiTGKw7mXsmVqn69WUWL+JDoHnXMUjftIDLB7WHBnLsDcY3YunwBRu2ri7IywBDQ==
X-Received: by 2002:a17:90b:300c:: with SMTP id hg12mr8533144pjb.75.1573163800561;
        Thu, 07 Nov 2019 13:56:40 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id b17sm4046597pfr.17.2019.11.07.13.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 13:56:40 -0800 (PST)
Date:   Thu, 07 Nov 2019 13:56:40 -0800 (PST)
X-Google-Original-Date: Thu, 07 Nov 2019 13:56:36 PST (-0800)
Subject:     Re: QEMU RISC-V virt machine poweroff driver
In-Reply-To: <20191107212408.11857-1-hch@lst.de>
CC:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-0dedc685-73d2-4e7f-b608-69385a6e7a99@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 07 Nov 2019 13:24:06 PST (-0800), Christoph Hellwig wrote:
> Hi all,
>
> this patch add a driver for the test device in the Qemu RISC-V
> virt machine which allows properly shutting down the VM.
> It also is added to the riscv defconfig given that qemu-virt
> is the most popular riscv platform.

Thanks!  I'm assuming this is going in through some other tree, so

Acked-by: Palmer Dabbelt <palmer@dabbelt.com>
