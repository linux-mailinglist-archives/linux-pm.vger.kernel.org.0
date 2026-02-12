Return-Path: <linux-pm+bounces-42542-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDu8LsSMjWnq3wAAu9opvQ
	(envelope-from <linux-pm+bounces-42542-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 09:18:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB8312B304
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 09:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CE10315EBB2
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 08:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C436C2D29C8;
	Thu, 12 Feb 2026 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DUcK714m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7342D028A
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770884226; cv=pass; b=l1VRXp1IbJdme31yPTla2YVhk9y/e/aijClm8dDyqiaSN1Q+Hd1lH6ndDcS+aW15iqW0bNyS5PAE60KcoKbNX2ovt9jMe0axVapOwlWLuVVk0MlVvFpsfQS06zeP9UQ6+5siaDMQMeoi2W9ValiQoAFn18BX1NBefEJ8Cd4weCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770884226; c=relaxed/simple;
	bh=S3M88NLOx2+3TFb0/rxwMjCXvmBBor+LBjD5ln2DfrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQanpN+0XlrTk3ozK7X1J33PdG7hFhe1UnidxNeZAAdPPMydIDP94kwKMXcgwmajw1JeZE+oqyUOX4jbP+kUMG4KUUfi04LXVjK43FiYEDzGQf5lfx2kiTMmhf538GTB0AzG4Mg7+hSwR7/mWdSfK1hIuatgf0OX68pGUM8FGTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DUcK714m; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43638a3330dso3964431f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 00:17:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770884223; cv=none;
        d=google.com; s=arc-20240605;
        b=Hxn15V/sA0NnLCUKSsG71EYqgrT6WykvOzEZ/bTqFnkog7iomOie2QD17nA0KOG8Y/
         Hkq2Lj/l71bxnWMmV7kC3oPhjhxvmylv/1ZQ44tdZzjhnxZkZ768y+4nFp12tOx2nJju
         oG9q2l2o+F8W8zAMTASyG5FKR6lM2w/hgMFVnyIZT2uuGzYl7/3JwRf4b1gOYrALCDLV
         AXJM0Ix2OTSE+qlubCmKhCLCDdnzohtCvkfOAP5AqWtzx1m2SKS0lpN/1H1taH0DItCA
         Zv/z1/Qup6nV/jT+mIgAS5viRsTbKEcs/7QDWcxzWz9nQXBoyzUqaSTWCFjpY2kCKqz+
         Is2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NpjJ+bXgoJAJdq6/RHAgpjIs0bFSGiAauGnbv0NC43o=;
        fh=qJGOjNHF3QDZn4hrLJtRJSZl9RzxZBjYE8D5H0HlOiA=;
        b=hbjCdaRTwNDC/aDCUfVK4R+snrSco9po46gXBc7Ebi5iwUrbJSdX9kodnvZzkBqf65
         m/eyJh1JbF6rOSJNbMiiiEkpimRpjeX+fLrbl0Q5bIEkbkUsoUgTGHhClLSiZJvpFxV2
         Vax4cZUhtM7pHqawmUMeq0rdOyjjavhhOy/mi5wtEruXQbuCGIds5AxDJBcahebOlRIN
         tWBTU4mht7zJ+tsG5lXB2IXWAzMafSukU9xN6nVDRBnlJDVwe7omTb19UWC5soQ+WF9W
         w8BuCFt/WXUHQlETTQ+6y68azN/e9hoMTh76xAYYwZKSuPelAINmekIGyRuhRITtxRjh
         amIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770884223; x=1771489023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpjJ+bXgoJAJdq6/RHAgpjIs0bFSGiAauGnbv0NC43o=;
        b=DUcK714mjOBKzFSnAQinbxouj+L6rdPZtvVxBg7o9Ayys3so0n9us8r8KP3ZSoaGwJ
         YPWUkWG7TDKgQA61EOMAUg8WjbdpYAiZ4gZJA2O6w102qY69/qBDWxlt3Y2y6q6L5SRH
         f4Bd60K1TDN91wUNQUHpyILwdQqvWKrJFq8XCUCq+FcAJrkceBvU/OwGI0pfPIrI87pK
         XM6P5c9XSOSPI3FCjBYkHD5gaja3w5uI5MYrL/G+BYCtW4wRTmlCOeF7pYG88Mc1sWP6
         40KzZ3p6Ewv9Y6Tpl5FxzNTiCWdjtWLMNHs7rJ/MA6ez2cDOCjyTEKQPzbKwwhrAAZly
         ka/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770884223; x=1771489023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NpjJ+bXgoJAJdq6/RHAgpjIs0bFSGiAauGnbv0NC43o=;
        b=kdOiY6djtKf4oDENKHzz06NGLjE7kGHFI2IpKTgXVC2UdKR32we1UgpwbLc9+qj+l2
         cNiPxifAWVf5VZvoBQ/YWf8ggVHH65VTidUzcubD5BV7s2tASYLQ3eLVgNlwRQ1kYMhl
         d+TnzDYm5uxJU266sMagDMi9+akupT12wemsA+iviEEkQqLWoIK6CLykJIbrVeHV0eum
         ftOKe2yjRehAvSwV3iBW9OjnwMjZnIjLhEjZbpreVzJOv0fDh2N4U4Dd9ZPfCYLzUaPc
         eCQvD6fgnJz/CEH4Oc7pt9HsC3W7/XkBnjIJISsN2eVJziY4QjZWrEoPJHTg1UmAF9Gi
         tI4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUS1P2xbDTJLqN9F80a7h3pNVZXN163+e03bM2eSRmesqDlkG5UWe6xarNmLjBQvH5n8lC3VlgvJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfcrOjmHiVuDS4SwIFvVSd2s4pACTZYaIxA2oZPuQx/l5n968l
	ldu7hDTBRD2UxHrOmq1GEHkXVU8yboQKp85IOFUGmalxlaZwMHNw0P1GJJhQDUaGNGuJRNwxCus
	1z6LJANk7c++QDU+xLnjpR6P5lClUCya1gSOFSWu6
X-Gm-Gg: AZuq6aLxv5LyKIN0OaC3+H77VY3aJNlZfWXvkEvE48ZpZ0wBlNlrJ0VRtf7cPDv097g
	W523rL+e9mnDqCTln7BeAzLTsgLrGk20/yWtcoGnCT3M/All39vd1uSU0hX72VBzxJKwRgPqabp
	uOMbY4uRxs7OqFj22S2rj8sNUqab5p2mynhzpHXwATd08um2fQtHa0G/2Fv7viLQJuu591rQb8U
	LU/hzxh4Z10nhzD+r4J7BMNM3ActZnDDMLRVWnvfJHNREHcrL4TtpDQGH5va9+jYZUI97seT5Rz
	Dq6ZfthEIale0HwKCaTlIsWbc7w4LC+cK0VZgA==
X-Received: by 2002:a05:6000:1a89:b0:437:678b:83ca with SMTP id
 ffacd0b85a97d-4378ac99f00mr3631820f8f.50.1770884222766; Thu, 12 Feb 2026
 00:17:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <518D8B09-B9A1-4DB4-85CD-37A2DD3D5FB1@collabora.com>
 <DFSLCI9U4NCW.2HI2UPUI7G134@kernel.org> <20260119-weightless-pelican-of-anger-190db0@houat>
 <DFSN4FDCYHMW.3J3237PEBV2ZP@kernel.org> <20260122-majestic-masterful-jaguarundi-d0abde@houat>
 <2F3D3A40-6EF9-46FC-A769-E5A3AAF67E65@collabora.com> <20260204-nickel-seal-of-poetry-8fdefb@houat>
 <91A92D84-1F2E-45F3-82EC-6A97D32E2A78@collabora.com> <20260204-angelic-vermilion-beagle-fd1507@houat>
 <20260209105047.693f2515@fedora> <20260211-flawless-feathered-boar-0b87ad@houat>
In-Reply-To: <20260211-flawless-feathered-boar-0b87ad@houat>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 12 Feb 2026 09:16:51 +0100
X-Gm-Features: AZwV_QinKyXJ-A463YThqNsT1M__XmmPzGQJrynVFHR1tMFsQH08Zqmn37iT6Tc
Message-ID: <CAH5fLgiQE7mJBpAxv6xTVKKFWadg2GdVe31hRM6gNk3Vah61MA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
To: Maxime Ripard <mripard@kernel.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Danilo Krummrich <dakr@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Drew Fustini <fustini@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42542-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[collabora.com,kernel.org,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3EB8312B304
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 5:37=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> On Mon, Feb 09, 2026 at 10:50:47AM +0100, Boris Brezillon wrote:
> > Hi Maxime,
> >
> > On Wed, 4 Feb 2026 15:34:29 +0100
> > Maxime Ripard <mripard@kernel.org> wrote:
> >
> > > On Wed, Feb 04, 2026 at 09:43:55AM -0300, Daniel Almeida wrote:
> > > > > I'm probably missing something then, but let's assume you have a =
driver
> > > > > that wants its clock prepared and enabled in an hypothetical enab=
le()
> > > > > callback, and disabled / unprepared in a disable() callback.
> > > > >
> > > > > From a PM management perspective, this usecase makes total sense,=
 is a
> > > > > valid usecase, is widely used in the kernel, and is currently sup=
ported
> > > > > by both the C and Rust clk APIs.
> > > > >
> > > > > The only solution to this you suggested so far (I think?) to impl=
ement
> > > > > this on top of the new clk API you propose is to have a driver sp=
ecific
> > > > > enum that would store each of the possible state transition.
> > > >
> > > > Yes, you need an enum _if_ you want to model transitions at runtime=
. IIUC you
> > > > only need two variants to implement the pattern you described. I do=
 not
> > > > consider this  =E2=80=9Cboilerplate=E2=80=9D, but rather a small co=
st to pay.
> > >
> > > A maintenance cost to pay by every driver is kind of the textbook
> > > definition of boilerplate to me.
> > >
> > > > I would understand if this was some elaborate pattern that had to b=
e
> > > > implemented by all drivers, but a two-variant enum is as
> > > > straightforward as it gets.
> > >
> > > And yet, that framework has dozens of helpers that do not remove
> > > anything from drivers but a couple of lines. So surely its users must
> > > find value in reducing that boilerplate as much as possible. And you =
do
> > > implement some of them, so you must find value in that too.
> > >
> > > > > That's the boilerplate I'm talking about. If every driver wanting=
 to
> > > > > implement that pattern has to make such an enum, with all the rel=
evant
> > > > > traits implementation that might come with it, we go from an API =
where
> > > > > everything works at no-cost from a code-size perspective to a sit=
uation
> > > > > where every driver has to develop and maintain that enum.
> > > >
> > > > There are no "traits that come with it". It's just an enum, with tw=
o
> > > > variants.
> > > >
> > > > > API where everything works at no-cost
> > > >
> > > > The previous API was far from =E2=80=9Ceverything works=E2=80=9D. I=
t was fundamentally
> > > > broken by design in multiple ways, i.e.:
> > >
> > > Out of context and not what I meant, but ok.
> > >
> > > > > a) It only keeps track of a count to clk_get(), which means that =
users have
> > > > > to manually call disable() and unprepare(), or a variation of tho=
se, like
> > > > > disable_unprepare().
> > > > >
> > > > > b) It allows repeated calls to prepare() or enable(), but it keep=
s no track
> > > > > of how often these were called, i.e., it's currently legal to wri=
te the
> > > > > following:
> > > > >
> > > > > clk.prepare();
> > > > > clk.prepare();
> > > > > clk.enable();
> > > > > clk.enable();
> > > > >
> > > > > And nothing gets undone on drop().
> > > >
> > > > IMHO, what we have here is an improvement that has been long overdu=
e.
> > >
> > > Nothing is absolute. It is indeed an improvement on the refcounting s=
ide
> > > of things and general safety of the API for the general case. I don't
> > > think I ever questionned that.
> > >
> > > However, for the use-cases we've been discussing (and dozens of drive=
rs
> > > implementing it), it also comes with a regression in the amount of co=
de
> > > to create and maintain. They used to be able to only deal with the Cl=
k
> > > structure, and now they can't anymore.
> > >
> > > You might find that neglible, you might have a plan to address that i=
n
> > > the future, etc. and that's fine, but if you can't acknowledge that i=
t's
> > > indeed happening, there's no point in me raising the issue and
> > > continuing the discussion.
> >
> >
> > Okay, let's see if I can sum-up the use case you'd like to support. You
> > have some PM hooks, which I'm assuming are (or will be) written in
> > rust. It will probably take the form of some Device{Rpm,Pm} trait to
> > implement for your XxxDeviceData (Xxx being the bus under which is
> > device is) object (since I've only recently joined the R4L effort, I
> > wouldn't be surprised if what I'm describing already exists or is
> > currently being proposed/reviewed somewhere, so please excuse my
> > ignorance if that's the case :-)).
> >
> > The way I see it, rather than having one enum per clk/regulator/xxx
> > where we keep track of each state individually, what we could have is a
> >
> > trait DevicePm {
> >       type ResumedState;
> >       type SuspendedState;
> >
> >       fn resume(&self, state: SuspendedState) -> Result<ResumedState, E=
rror<SuspendedState>>;
> >       fn suspend(&self, state: SuspendedState) -> Result<SuspendedState=
, Error<ResumedState>>;
> > };
> >
> > enum DeviceState<T: DevicePm> {
> >       Resumed(T::ResumedState),
> >       Suspended(T::SuspendedState),
> > };
> >
> > and then in your driver:
> >
> > MySuspendedDeviceResources {
> >       xxx_clk: Clk<Unprepared>,
> > };
> >
> > MyResumedDeviceResources {
> >       xxx_clk: Clk<Enabled>,
> > };
> >
> > implem DevicePm for MyDevice {
> >       type ResumedState =3D MyResumedDeviceResources;
> >       type SuspendedState =3D MySuspendedDeviceResources;
> >
> >       fn resume(&self, state: SuspendedState) -> Result<ResumedState, E=
rror<SuspendedState>> {
> >               // FIXME: error propagation not handled
> >               let enabled_clk =3D state.xxx_clk.clone().prepare()?.enab=
le()?;
> >
> >               Ok(ResumedState {
> >                       xxx_clk: enabled_clk,
> >               });
> >       }
> >
> >       fn suspend(&self, state: ResumedState) -> Result<SuspendedState, =
Error<ResumedState>> {
> >               // FIXME: error propagation not handled
> >               let unprep_clk =3D state.xxx_clk.clone().disable().unprep=
are();
> >
> >               Ok(SuspendedState {
> >                       xxx_clk: unprep_clk,
> >               });
> >       }
> > };
>
> I'm not sure we need to associate this with the suspend/resume state eith=
er.
>
> > With this model, I don't think Daniel's refactor goes in the way of mor=
e
> > generalization at the core level, it's just expressed differently than
> > it would be if it was written in C. And I say that as someone who strug=
gles
> > with his C developer bias every time I'm looking at or trying to write
> > rust code.
> >
> > As others have said in this thread (Danilo and Gary), and after having
> > played myself with both approaches in Tyr, I do see this shift from man=
ual
> > prepare/enable to an RAII approach as an improvement, so I hope we can
> > find a middle-ground where every one is happy.
>
> I do think we can find a compromise though. Miguel suggested for example
> to make the current enable/prepare/disable/unprepare function unsafe,
> and that's totally reasonable to me.
>
> Then we can implement the "managed" clock version on that unsafe API,
> and we would end up with a "raw", unsafe, version kind of equivalent to
> the one we have today, and where callers would have to justify why their
> usage of the API is actually safe, or the new, managed, variant that is
> safe and can be easily used by most drivers.
>
> And we can call these RawClk vs Clk, or Clk vs ManagedClk, or whatever.
>
> How does that sound?

If you make the raw API unsafe, then that's okay but any use of an
unsafe API from a driver will receive very hard scrutiny. Yes, there
are occasionally good reasons to use unsafe from drivers, but the
entire point of this Rust exercise is to isolate unsafe code outside
of drivers as much as possible.

If Daniel's proposal is inconvenient for some drivers, it would be far
better to have a third API that is both safe and convenient for those
drivers.

Alice

